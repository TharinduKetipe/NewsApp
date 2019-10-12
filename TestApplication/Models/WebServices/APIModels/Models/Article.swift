//
//  Article.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 10/9/19.
//  Copyright © 2019 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class Article: APIModel {

    var sourceName: String?
    var author: String?
    var title: String?
    var articleDescription: String?
    var articleUrl: String?
    var thumbImage: String?
    var publishedDate: String?
    var content: String?
    
    override func mapping(map: Map) {
        sourceName <- map["source.name"]
        author <- map["author"]
        title <- map["title"]
        articleDescription <- map["description"]
        articleUrl <- map["url"]
        thumbImage <- map["urlToImage"]
        publishedDate <- map["publishedAt"]
        content <- map["content"]
    }
}
