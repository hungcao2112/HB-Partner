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
import Reachability
import CoreLocation

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
    
     public static func getProfile(phone: String, onSuccess: ((_ response: Profile, _ message: String) -> ())?, onError: ((_ errorMessage: String) -> ())? = nil) {
           let params = ["partner_phone": phone]
           Alamofire.request(Config.GET_PROFILE_URL, method: .post, parameters: params).responseObject { (response: DataResponse<ProfileResponse>) in
               switch response.result {
               case .success(let data):
                    guard let profile = data.data?.first else {
                        onError?(data.message ?? "")
                        return
                    }
                    onSuccess?(profile, data.message ?? "")
               case .failure(let error):
                    onError?(error.localizedDescription)
                    break
               }
           }
       }
    
    public static func sendGPSIP(phone: String, latitude: Double, longitude: Double, ipAddress: String, networkType: String, onSuccess: ((_ response: BaseResponse, _ message: String) -> ())?, onError: ((_ errorMessage: String) -> ())? = nil) {
        let params = ["partner_phone": phone,
                      "latitude": latitude,
                      "longtitude": longitude,
                      "ip_address": ipAddress,
                      "network_type": networkType] as [String : Any]
        Alamofire.request(Config.GET_PROFILE_URL, method: .post, parameters: params).responseObject { (response: DataResponse<BaseResponse>) in
            switch response.result {
            case .success(let data):
                onSuccess?(data, data.message ?? "")
            case .failure(let error):
                onError?(error.localizedDescription)
                break
            }
        }
    }
    
    public static func getBadges(phone: String, onSuccess: ((_ response: BadgeResponse, _ message: String) -> ())?, onError: ((_ errorMessage: String) -> ())? = nil) {
        let params = ["partner_phone": phone]
        Alamofire.request(Config.GET_BADGE_URL, method: .post, parameters: params).responseObject { (response: DataResponse<BadgeResponse>) in
            switch response.result {
            case .success(let data):
                onSuccess?(data, data.message ?? "")
            case .failure(let error):
                onError?(error.localizedDescription)
                break
            }
        }
    }
    
    public static func logout(phone: String, onSuccess: ((_ response: BaseResponse, _ message: String) -> ())?, onError: ((_ errorMessage: String) -> ())? = nil) {
        let params = ["partner_phone": phone]
        Alamofire.request(Config.GET_BADGE_URL, method: .post, parameters: params).responseObject { (response: DataResponse<BaseResponse>) in
            switch response.result {
            case .success(let data):
                onSuccess?(data, data.message ?? "")
            case .failure(let error):
                onError?(error.localizedDescription)
                break
            }
        }
    }
}
