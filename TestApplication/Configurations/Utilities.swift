//
//  Utilities.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 8/5/19.
//  Copyright © 2019 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class Utilities: NSObject {
    
    class func AlertWithOkAction(view:UIViewController, title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        view.present(alert, animated: true, completion: nil)
    }
    
    class func downloadImage(url:String, imageView:UIImageView) {
        let url = URL(string: url)
        if let urlStr = url {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: urlStr)
                if data != nil {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: data!)
                    }
                }
            }
        }
    }
    
    class func saveUserData(user:User) {
        let userDefaults = UserDefaults.standard
        let encodedData = try? PropertyListEncoder().encode(user)
        userDefaults.set(encodedData, forKey: "userData")
        userDefaults.synchronize()
    }
    
    class func userData() -> User {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.value(forKey:"userData") as? Data {
            return try! PropertyListDecoder().decode(User.self, from:data)
        }
        return User()
    }

}
