//
//  User.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 10/12/19.
//  Copyright © 2019 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit

class User: NSObject, Codable {
    
    var name: String?
    var username: String?
    var country: String?
    var age: String?
    var validity:Bool?
    
    override init() {
        self.name = ""
        self.username = ""
        self.country = ""
        self.age = ""
        self.validity = false
    }
    
    convenience init(name:String, usernme:String, country:String, age:String) {
        self.init()
        self.name = name
        self.username = usernme
        self.country = country
        self.age = age
        self.validity = true
    }
}
