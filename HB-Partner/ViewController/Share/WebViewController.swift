//
//  WebViewController.swift
//  HB-Partner
//
//  Created by Hung Cao on 9/22/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!

    var requestURL: String = ""
    var cookieDomain: String = ""
    var cookiePath: String = ""
    var cookieValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    

    private func setupWebView() {
        let cookie = HTTPCookie(properties: [.domain: cookieDomain,
                                             .path: cookiePath,
                                             .name: "MANTIS_STRING_COOKIE",
                                             .value: cookieValue])
        
        guard let cookies = cookie else { return }
        webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookies, completionHandler: nil)
        let urlRequest = URLRequest(url: URL(string: requestURL)!)
        webView.load(urlRequest)
    }

}
