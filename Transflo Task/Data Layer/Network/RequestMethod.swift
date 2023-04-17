//
//  RequestMethod.swift
//  Transflo Task
//
//  Created by Youssef on 15/04/2023.
//  Copyright © 2022 Youssef. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI

@propertyWrapper
struct GET<T: BaseResponse> {
    
    var wrappedValue: any Network<T> {
        mutating get {
            return request
        }
    }
    
    private var request: any Network<T>

    init(url: RequestUrl, encoding: RequestEncodingType = .json) {
        request = AsyncRequest<T>(request: NetworkRequest(url: url, method: .get, encoding: encoding))
    }
}

@propertyWrapper
struct POST<T: BaseResponse> {
    
    var wrappedValue: any Network<T> {
        mutating get {
            return request
        }
    }
    
    private var request: any Network<T>

    init(url: RequestUrl, encoding: RequestEncodingType = .json) {
        request = AsyncRequest<T>(request: NetworkRequest(url: url, method: .post, encoding: encoding))
    }
}
