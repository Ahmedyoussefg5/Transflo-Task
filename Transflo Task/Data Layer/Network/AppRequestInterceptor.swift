//
//  AppRequestInterceptor.swift
//  Transflo Task
//
//  Created by Youssef on 15/04/2023.
//  Copyright © 2022 Youssef. All rights reserved.
//

import Foundation
import Alamofire

class AppRequestInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue("en", forHTTPHeaderField: "Accept-Language")
        urlRequest.setValue("os", forHTTPHeaderField: "ios")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}
