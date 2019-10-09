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
    
    func getPublicIPAddress() -> String {
        var publicIP = ""
        do {
            try publicIP = String(contentsOf: URL(string: "https://www.bluewindsolution.com/tools/getpublicip.php")!, encoding: String.Encoding.utf8)
            publicIP = publicIP.trimmingCharacters(in: CharacterSet.whitespaces)
        }
        catch {
            print("Error: \(error)")
        }
        return publicIP
    }
    
    func getBadges() {
        accountKit.requestAccount { [weak self] (account, error) in
            guard let phone = account?.phoneNumber?.phoneNumber else { return }
            Request.getBadges(phone: "0\(phone)", onSuccess: { [weak self] (response, message) in
                guard let `self` = self else { return }
                print("\(response)")
                if let badge = response.badge {
                    if badge == 0 {
                        self.tabBar.items?[0].badgeValue = nil
                    }
                    else {
                        self.tabBar.items?[0].badgeValue = "\(badge)"
                    }
                    
                }
                if let badgeNote = response.badgeNote {
                    if badgeNote == 0 {
                        self.tabBar.items?[1].badgeValue = nil
                    }
                    else {
                        self.tabBar.items?[1].badgeValue = "\(badgeNote)"
                    }
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
        SwiftEventBus.onMainThread(self, name: "PRESENT_NOTIFICATION_EVENT") { (_) in
            self.getBadges()
            print("-----: get badges")
        }
        
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
        manager.stopUpdatingLocation()
        guard let lat = locations.first?.coordinate.latitude,
            let long = locations.first?.coordinate.latitude else { return }
        print("lat: \(lat), long: \(long)")
        let ipAddress = getPublicIPAddress()
        accountKit.requestAccount { [weak self] (account, error) in
            guard let `self` = self else { return }
            guard let phone = account?.phoneNumber?.phoneNumber else { return }
            self.reachability.whenReachable = { reachability in
                var networkType: String = ""
                switch reachability.connection {
                case .none:
                    break
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
            do {
                try self.reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }
    }
}
