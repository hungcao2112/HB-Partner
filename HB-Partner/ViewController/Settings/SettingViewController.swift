//
//  SettingViewController.swift
//  HB-Partner
//
//  Created by Hung Cao on 9/29/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import UIKit
import AccountKit

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
    
    private func requestAccount() {
        accountKit.requestAccount { [weak self] (account, error) in
            guard let phone = account?.phoneNumber?.phoneNumber else { return }
            self?.getProfile(phone: "0\(phone)")
        }
    }
    
    private func getProfile(phone: String) {
        Request.getProfile(phone: phone, onSuccess: { [weak self] (profile, message) in
            self?.nameLabel.text = profile.companyName
            self?.phoneLabel.text = profile.representativeContact
            self?.emailLabel.text = profile.companyId
            self?.addressLabel.text = profile.companyAddress
        }) { [weak self] (message) in
            self?.showToast(message)
        }
    }
}
