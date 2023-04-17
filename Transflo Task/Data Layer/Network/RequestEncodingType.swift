//
//  RequestEncodingType.swift
//  Transflo Task
//
//  Created by Youssef on 15/04/2023.
//

import Foundation
import Alamofire

enum RequestEncodingType {
    case json
    case url
    
    var value: ParameterEncoding {
        switch self {
        case .json:
           return JSONEncoding.default
        case .url:
            return URLEncoding.default
        }
    }
}
