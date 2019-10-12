//
//  Constants.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 8/5/19.
//  Copyright © 2019 Tharindu Ketipearachchi. All rights reserved.
//

import Foundation

struct Constants {
    static let baseUrl = "https://newsapi.org/"
    static let apiKey = "4a126a2d305f4898b241d4f869f21121"
}

struct NotificationIds {
    
}

struct APIRequestMetod {
    static let topHeadlines = "v2/top-headlines?"
    static let newsByKeyword = "v2/everything?q="
}

struct APIRequestKeys {
    static let country = "country"
    static let apiKey = "apiKey"
}
