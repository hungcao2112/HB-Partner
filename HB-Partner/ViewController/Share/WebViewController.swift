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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    

    private func setupWebView() {
        let cookie = HTTPCookie(properties: [.domain: "admin2.hobien.kjclub.org",
                                             .path: "/m_view_all_bug_page.php",
                                             .name: "MANTIS_STRING_COOKIE",
                                             .value: "beGvszJRVI769dF4TtSHDe2UJawKHA4AOYu2kZZk-uF8Jq1mtrtPySINButI-4pH"])
        webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie!, completionHandler: nil)

        var urlRequest = URLRequest(url: URL(string: "http://admin2.hobien.kjclub.org/m_view_all_bug_page.php")!)
        webView.load(urlRequest)
    }

}
