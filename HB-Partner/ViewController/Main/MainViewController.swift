//
//  MainViewController.swift
//  HB-Partner
//
//  Created by Hung Cao on 9/19/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import UIKit
import CoreLocation
import Reachability
import AccountKit
import Firebase
import SwiftEventBus

class MainViewController: UITabBarController {

    var token: String = ""
    
    private var locationManager = CLLocationManager()
    private var reachability = Reachability()!
    private var accountKit = AccountKit(responseType: .accessToken)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbarViewController()
        setupLocation()
        getBadges()
        registerDevice()
        handleNotifications()
    }

    private func setupTabbarViewController() {
        for viewController in viewControllers ?? [] {
            if let nvc = viewController as? UINavigationController, let vc = nvc.topViewController as? NewViewController {
                vc.requestURL = Config.MENU_NEW_WEBVIEW_URL
            }
            else if let nvc = viewController as? UINavigationController, let vc = nvc.topViewController as? ProcessingViewController {
                vc.requestURL = Config.MENU_PROCESSING_WEBVIEW_URL
            }
            else if let nvc = viewController as? UINavigationController, let vc = nvc.topViewController as? ClosedViewController {
                vc.requestURL = Config.MENU_CLOSED_WEBVIEW_URL
            }
        }
    }
    
    private func setupLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func getIPAddress() -> String {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }

                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                    // wifi = ["en0"]
                    // wired = ["en2", "en3", "en4"]
                    // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]

                    let name: String = String(cString: (interface!.ifa_name))
                    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address ?? ""
    }
    
    private func getBadges() {
        accountKit.requestAccount { [weak self] (account, error) in
            guard let phone = account?.phoneNumber?.phoneNumber else { return }
            Request.getBadges(phone: "0\(phone)", onSuccess: { [weak self] (response, message) in
                guard let `self` = self else { return }
                if let badge = response.badge, badge != 0 {
                    self.tabBar.items?[0].badgeValue = "\(badge)"
                }
                if let badgeNote = response.badgeNote, badgeNote != 0 {
                    self.tabBar.items?[1].badgeValue = "\(badgeNote)"
                }
            }, onError: nil)
        }
    }
    
    private func registerDevice() {
        InstanceID.instanceID().instanceID { [weak self] (result, error) in
            guard let `self` = self else { return }
            guard let result = result else {
                return
            }
            let fcmToken = result.token
            let deviceToken = Messaging.messaging().apnsToken?.hexString ?? ""
            
            self.accountKit.requestAccount { [weak self] (account, error) in
                Request.registerDevice(phone: "0\(account?.phoneNumber?.phoneNumber ?? "")", token: fcmToken, deviceId: deviceToken, onSuccess: { (response, message) in
                    self?.showToast(message)
                }) { (message) in
                    self?.showToast(message)
                }
            }
        }
    }
    
    private func handleNotifications() {
        SwiftEventBus.onMainThread(self, name: "RECEIVE_NOTIFICATION_EVENT") { (result) in
            guard let notification = result?.object as? RemoteNotification else { return }
            self.getBadges()
            if notification.type == "new" {
                self.selectedIndex = 0
            }
            else if notification.type == "note" {
                if let vc = self.viewControllers?[1] as? ProcessingViewController {
                    if let bugId = notification.bugId {
                        let urlString = "http://admin2.hobien.kjclub.org/m_view.php?id=\(bugId)#bugnoteadd"
                        vc.requestURL = urlString
                    }
                }
                self.selectedIndex = 1
            }
        }
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = locations.last!.coordinate.latitude
        let long = locations.last!.coordinate.longitude
        let ipAddress = getIPAddress()
        accountKit.requestAccount { [weak self] (account, error) in
            guard let `self` = self else { return }
            guard let phone = account?.phoneNumber?.phoneNumber else { return }
            self.reachability.whenReachable = { reachability in
                var networkType: String = ""
                switch reachability.connection {
                case .none:
                    return
                case .wifi:
                    networkType = "WIFI"
                case .cellular:
                    networkType = "4G"
                }
                Request.sendGPSIP(phone: "0\(phone)", latitude: lat, longitude: long, ipAddress: ipAddress, networkType: networkType, onSuccess: { [weak self] (response, message) in
                    self?.showToast(message)
                }) { [weak self] (message) in
                    self?.showToast(message)
                }
            }
        }
    }
}
