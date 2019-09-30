//
//  Config.swift
//  HB-Partner
//
//  Created by Hung Cao on 9/29/19.
//  Copyright © 2019 Hung Cao. All rights reserved.
//

import Foundation

class Config {
    
    public static let PHONE_VALIDATION_URL = "http://hobien.kjclub.org/webhook/partner/CheckValidPhone.php"
    public static let GET_PROFILE_URL = "http://hobien.kjclub.org/webhook/partner/v1/profile"
    public static let SEND_GPS_IP_URL = "http://hobien.kjclub.org/webhook/partner/v1/gpsip"
    
    public static let COOKIE_DOMAIN = "admin2.hobien.kjclub.org"
    
    // Menu new
    public static let MENU_NEW_WEBVIEW_URL = "http://admin2.hobien.kjclub.org/m_view_all_bug_page.php"
    
    // Menu processing
    public static let MENU_PROCESSING_WEBVIEW_URL = "http://admin2.hobien.kjclub.org/m_view_all_bug_ing_page.php"
    
    // Menu closed
    public static let MENU_CLOSED_WEBVIEW_URL = "http://admin2.hobien.kjclub.org/m_view_all_bug_ok_page.php"
}
