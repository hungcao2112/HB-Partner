//
//  Profile.swift
//  HB-Partner
//
//  Created by Hung Cao on 9/29/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import UIKit
import ObjectMapper

class ProfileResponse: Mappable {
    
    var status: Bool?
    var code: Int?
    var message: String?
    var data: [Profile]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
}

class Profile: Mappable {

    var companyName: String?
    var representativeContact: String?
    var companyId: String?
    var companyAddress: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        companyName <- map["COMPANY_NM"]
        representativeContact <- map["REPRESENTATIVE_CONTACT"]
        companyId <- map["COMPANY_ID"]
        companyAddress <- map["COMPANY_ADDRESS"]
    }
}
