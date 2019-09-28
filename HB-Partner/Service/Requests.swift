//
//  Requests.swift
//  HB-Partner
//
//  Created by Hung Cao on 9/29/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

class Request {
    
    public static func validatePhone(phone: String, onSuccess: ((_ response: PhoneValidationResponse, _ message: String) -> ())?, onError: ((_ errorMessage: String) -> ())? = nil) {
        let params = ["phone": phone]
        Alamofire.request(Config.PHONE_VALIDATION_URL, method: .post, parameters: params).responseObject { (response: DataResponse<PhoneValidationResponse>) in
            switch response.result {
            case .success(let data):
                if data.error == false {
                    onSuccess?(data, data.message ?? "")
                }
                else {
                    onError?(data.message ?? "")
                }
                break
            case .failure(let error):
                onError?(error.localizedDescription)
                break
            }
            
        }
    }
    
}
