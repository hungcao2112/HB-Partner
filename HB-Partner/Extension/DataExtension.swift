//
//  DataExtension.swift
//  HB-Partner
//
//  Created by Hung Cao on 10/2/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import Foundation

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
