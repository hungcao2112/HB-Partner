//
//  PhoneValidationResponse.swift
//  HB-Partner
//
//  Created by Hung Cao on 9/29/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import UIKit
import ObjectMapper

class PhoneValidationResponse: Mappable {
    
    var error: Bool?
    var token: String?
    var message: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        error <- map["error"]
        token <- map["token"]
        message <- map["message"]
    }
}
