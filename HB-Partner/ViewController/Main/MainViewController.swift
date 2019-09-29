//
//  MainViewController.swift
//  HB-Partner
//
//  Created by Hung Cao on 9/19/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    var token: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbarViewController()
    }
    

    private func setupTabbarViewController() {
        for viewController in viewControllers ?? [] {
            if let nvc = viewController as? UINavigationController, let vc = nvc.topViewController as? NewViewController {
                vc.requestURL = Config.MENU_NEW_WEBVIEW_URL
            }
            else if let nvc = viewController as? UINavigationController, let vc = nvc.topViewController as? ProcessingViewController {
                vc.requestURL = Config.MENU_PROCESSING_WEBVIEW_URL
            }
            else if let nvc = viewController as? UINavigationController, let vc = nvc.topViewController as? ClosedViewController {
                vc.requestURL = Config.MENU_CLOSED_WEBVIEW_URL
            }
        }
    }
}
