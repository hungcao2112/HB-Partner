//
//  LoginViewController.swift
//  HB-Partner
//
//  Created by Hung Cao on 9/20/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import UIKit
import AccountKit

class LoginViewController: UIViewController {

    var accountKit: AccountKit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccountKit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let _ = accountKit.currentAccessToken else {
            return
        }
        self.goToMain()
    }
    
    private func setupAccountKit() {
        accountKit = AccountKit(responseType: .accessToken)
    }
    
    private func prepareLoginViewController(loginViewController: AKFViewController) {
        loginViewController.delegate = self
        loginViewController.uiManager = SkinManager(skinType: .classic, primaryColor: R.color.primary_red()!)
    }
    
    private func loginWithPhone() {
        let inputState = UUID().uuidString
        let vc = accountKit.viewControllerForPhoneLogin(with: nil, state: inputState)
        vc.isSendToFacebookEnabled = true
        prepareLoginViewController(loginViewController: vc)
        present(vc, animated: true, completion: nil)
    }
    
    private func goToMain() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.switchRootViewController(R.storyboard.main.mainViewController()!)
    }
    
    @IBAction func onLoginButtonClicked(_ sender: Any) {
        loginWithPhone()
    }
}

extension LoginViewController: AKFViewControllerDelegate {
    func viewController(_ viewController: UIViewController & AKFViewController, didCompleteLoginWith accessToken: AccessToken, state: String) {
        goToMain()
    }
}

