//
//  BadgeResponse.swift
//  
//
//  Created by Hung Cao on 10/1/19.
//

import UIKit
import ObjectMapper

class BadgeResponse: BaseResponse {

    var badge: Int?
    var badgeNote: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        badge <- map["badge"]
        badgeNote <- map["badge_note"]
    }
}
