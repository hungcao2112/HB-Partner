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

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var accountKit: AccountKit!
    private var validationResponse: PhoneValidationResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccountKit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let _ = accountKit.currentAccessToken else {
            return
        }
        self.requestAccount()
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
        let mainViewController = R.storyboard.main.mainViewController()!
        mainViewController.token = validationResponse?.token ?? ""
        appDelegate.switchRootViewController(mainViewController)
    }
    
    private func requestAccount() {
        self.loadingIndicator.startAnimating()
        accountKit.requestAccount { [weak self] (account, error) in
            guard let phone = account?.phoneNumber?.phoneNumber else { return }
            self?.validatePhone(phone: "0\(phone)")
        }
    }
    
    private func validatePhone(phone: String) {
        Request.validatePhone(phone: phone, onSuccess: { [weak self] (response, message) in
            self?.validationResponse = response
            self?.storeCookies(token: response.token ?? "")
            self?.goToMain()
            self?.showToast(message)
            self?.loadingIndicator.stopAnimating()
        }) { [weak self] (message) in
            self?.showToast(message)
            self?.loadingIndicator.stopAnimating()
        }
    }
    
    private func storeCookies(token: String) {
        let cookie = HTTPCookie(properties: [.domain: Config.COOKIE_DOMAIN,
                                             .path: "/",
                                             .name: "MANTIS_STRING_COOKIE",
                                             .value: token])
        guard let cookies = cookie else { return }
        HTTPCookieStorage.shared.setCookie(cookies)
        HTTPCookieStorage.shared.cookieAcceptPolicy = .always
    }
    
    @IBAction func onLoginButtonClicked(_ sender: Any) {
        loginWithPhone()
    }
}

extension LoginViewController: AKFViewControllerDelegate {
    func viewController(_ viewController: UIViewController & AKFViewController, didCompleteLoginWith accessToken: AccessToken, state: String) {
        requestAccount()
    }
}

