//
//  WebViewController.swift
//  HB-Partner
//
//  Created by Hung Cao on 9/22/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView
import AccountKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var accountKit = AccountKit(responseType: .accessToken)
    var requestURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLoading()
        if webView.url == nil {
            setupWebView()
        }
        else {
            webView.reloadFromOrigin()
        }
    }
    
    private func showLoading() {
        let activity = ActivityData(type: .ballGridPulse, color: R.color.primary_red())
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activity)
    }
    
    private func hideLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    private func addBackButton() {
        let backButton = UIBarButtonItem(image: R.image.ic_back()!, style: .plain, target: self, action: #selector(onBackButtonTapped))
        backButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    private func removeBackButton() {
        self.navigationItem.leftBarButtonItem = nil
    }
    
    private func setupWebView() {
        webView.backgroundColor = .white
        
        guard let cookies = HTTPCookieStorage.shared.cookies?.last  else { return }
        webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookies)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: URL(string: requestURL)!), with: [cookies])
    }
    
    private func logout() {
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
    
    private func goToLogin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.switchRootViewController(R.storyboard.login.loginViewController()!)
    }

    @objc private func onBackButtonTapped() {
        webView.goBack()
    }
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoading()
        if webView.canGoBack {
            addBackButton()
        }
        else {
            removeBackButton()
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else { return }
        if url.scheme == "tel" {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
            return
        }
        else if url.scheme == "sms" {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
            return
        }
        
        if url.absoluteString.contains("login_page.php") {
            self.logout()
            decisionHandler(.allow)
            return
        }
        if url.absoluteString.contains("m_view.php") || url.absoluteString.contains("m_view_all_bug_ing_page.php") {
            if let mainVC = self.tabBarController as? MainViewController {
                mainVC.getBadges()
            }
            decisionHandler(.allow)
            return
        }
        decisionHandler(.allow)
    }
}
