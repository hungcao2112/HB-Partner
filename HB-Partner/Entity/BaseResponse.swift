//
//  BaseResponse.swift
//  HB-Partner
//
//  Created by Hung Cao on 10/1/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseResponse: Mappable {
    
    var status: Bool?
    var code: Int?
    var message: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        status <- map["status"]
        code <- map["code"]
        message <- map["message"]
    }
}
