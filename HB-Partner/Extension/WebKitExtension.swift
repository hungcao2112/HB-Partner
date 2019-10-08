//
//  WebKitExtension.swift
//  HB-Partner
//
//  Created by Hung Cao on 10/5/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    
   func load(_ request: URLRequest, with cookies: [HTTPCookie]) {
      var request = request
      let headers = HTTPCookie.requestHeaderFields(with: cookies)
      for (name, value) in headers {
         request.addValue(value, forHTTPHeaderField: name)
      }
        DispatchQueue.main.async {
            self.load(request)
        }
      
   }
}
