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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    

    private func setupWebView() {
        webView.backgroundColor = .white
        
        guard let cookies = HTTPCookieStorage.shared.cookies?.last  else { return }
        webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookies, completionHandler: nil)
        var urlRequest = URLRequest(url: URL(string: requestURL)!)
        urlRequest.httpMethod = "GET"
        webView.load(urlRequest)
    }

}
