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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoading()
        setupWebView()
    }
    
    private func showLoading() {
        let activity = ActivityData(type: .ballGridPulse, color: R.color.primary_red())
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activity)
    }
    
    private func hideLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
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

    @IBAction func onBackButtonTapped(sender: Any) {
        webView.goBack()
    }
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoading()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            guard let url = navigationAction.request.url else {return}
            webView.load(URLRequest(url: url))
        }
        decisionHandler(.allow)
    }
}
