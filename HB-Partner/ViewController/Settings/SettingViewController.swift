//
//  SettingViewController.swift
//  HB-Partner
//
//  Created by Hung Cao on 9/29/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import UIKit
import AccountKit
import NVActivityIndicatorView

class SettingViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    private var accountKit = AccountKit(responseType: .accessToken)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAccount()
    }
    
    private func showLoading() {
        let activity = ActivityData(type: .ballGridPulse, color: R.color.primary_red())
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activity)
    }
    
    private func hideLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    private func requestAccount() {
        showLoading()
        accountKit.requestAccount { [weak self] (account, error) in
            guard let phone = account?.phoneNumber?.phoneNumber else {
                self?.hideLoading()
                return
            }
            self?.getProfile(phone: "0\(phone)")
        }
    }
    
    private func getProfile(phone: String) {
        Request.getProfile(phone: phone, onSuccess: { [weak self] (profile, message) in
            self?.nameLabel.text = profile.companyName
            self?.phoneLabel.text = profile.representativeContact
            self?.emailLabel.text = profile.companyId
            self?.addressLabel.text = profile.companyAddress
            self?.hideLoading()
        }) { [weak self] (message) in
            self?.showToast(message)
            self?.hideLoading()
        }
    }
    
    private func goToLogin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.switchRootViewController(R.storyboard.login.loginViewController()!)
    }
    
    @IBAction func onLogoutButtonTapped(_ sender: Any) {
        self.showLoading()
        accountKit.requestAccount { [weak self] (account, error) in
            guard let phone = account?.phoneNumber?.phoneNumber else {
                self?.hideLoading()
                return
            }
            Request.logout(phone: "0\(phone)", onSuccess: { [weak self] (response, message) in
                self?.accountKit.logOut { (loggedOut, error) in
                    self?.hideLoading()
                    if let _ = error { return }
                    self?.goToLogin()
                }
            }) { [weak self] (message) in
                self?.showToast(message)
                self?.hideLoading()
            }
        }
    }
}
