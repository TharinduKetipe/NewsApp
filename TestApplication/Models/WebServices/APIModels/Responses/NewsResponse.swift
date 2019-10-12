//
//  NewsResponse.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 10/9/19.
//  Copyright © 2019 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class NewsResponse: APIModel {

    var totalResuls: Int?
    var status: String?
    var news : [Article] = []
    
    override func mapping(map: Map) {
        totalResuls <- map["totalResults"]
        status <- map["status"]
        news <- map["articles"]
    }
}
