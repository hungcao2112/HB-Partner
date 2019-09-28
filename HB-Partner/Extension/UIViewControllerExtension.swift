//
//  UIViewControllerExtension.swift
//  HB-Partner
//
//  Created by Hung Cao on 9/29/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import Foundation
import Toaster

extension UIViewController {
    
    func showToast(_ text: String) {
        Toast(text: text).show()
    }
    
}
