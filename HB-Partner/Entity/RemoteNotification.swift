//
//  RemoteNotification.swift
//  HB-Partner
//
//  Created by Hung Cao on 10/7/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import UIKit
import ObjectMapper

class RemoteNotification: Mappable {
    
    var partner: String?
    var title: String?
    var message: String?
    var type: String?
    var bugId: String?
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        partner <- map["partner"]
        title <- map["title"]
        message <- map["message"]
        type <- map["type"]
        bugId <- map["bugid"]
    }
    
}
