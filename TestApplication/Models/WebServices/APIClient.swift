//
//  APIClient.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 8/5/19.
//  Copyright © 2019 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON

class APIClient: NSObject {
    
    enum APIResponseStatus : Int {
        case Success = 200
        case SuccessAlso = 201
        case ValidationError = 409
        case BadRequest = 400
        case UnAuthorized = 401
        case NotFound = 404
        case InternalServerError = 500
        case Other
    }
    
    static let shared = APIClient()
    
    private override init() {
        
    }
    
    func getHTTPHeaders() -> HTTPHeaders? {
        return ["Content-Type" : "application/json",
        ]
    }
}

extension APIClient {
    
    func topNews(country:String, completion:@escaping (APIResponseStatus, NewsResponse?) -> Void) {
        let apiRequest = Constants.baseUrl + APIRequestMetod.topHeadlines + APIRequestKeys.country + "=" + country + "&" + APIRequestKeys.apiKey + "=" + Constants.apiKey
        let request = AF.request( apiRequest,
                                  method: .get,
                                  encoding: JSONEncoding.default,
                                  headers: self.getHTTPHeaders())
        request.responseObject {
            (response:DataResponse<NewsResponse>) in
            switch response.result {
            case .success(_):
                completion(APIClient.APIResponseStatus(rawValue: (response.response?.statusCode)!)!, response.value!)
            case .failure(_):
                completion(APIClient.APIResponseStatus.Other, nil)
            }
        }
    }
    
    func newsByKeyword(keyword:String, completion:@escaping (APIResponseStatus, NewsResponse?) -> Void) {
        let apiRequest = Constants.baseUrl + APIRequestMetod.newsByKeyword + keyword + "&" + APIRequestKeys.apiKey + "=" + Constants.apiKey
        let request = AF.request( apiRequest,
                                  method: .get,
                                  encoding: JSONEncoding.default,
                                  headers: self.getHTTPHeaders())
        request.responseObject {
            (response:DataResponse<NewsResponse>) in
            switch response.result {
            case .success(_):
                completion(APIClient.APIResponseStatus(rawValue: (response.response?.statusCode)!)!, response.value!)
            case .failure(_):
                completion(APIClient.APIResponseStatus.Other, nil)
            }
        }
    }
    
}
