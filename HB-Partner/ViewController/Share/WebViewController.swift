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

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
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
        webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookies) { [weak self] in
            self?.webView.uiDelegate = self
            self?.webView.navigationDelegate = self
            self?.webView.allowsBackForwardNavigationGestures = true
            self?.webView.load(URLRequest(url: URL(string: self?.requestURL ?? "")!), with: [cookies])
        }
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
        decisionHandler(.allow)
    }
}
