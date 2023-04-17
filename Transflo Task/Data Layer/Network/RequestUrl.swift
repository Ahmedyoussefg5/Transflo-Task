//
//  RequestUrl.swift
//  Transflo Task
//
//  Created by Youssef on 15/04/2023.
//  Copyright © 2022 Youssef. All rights reserved.
//

import Foundation

enum RequestUrl {
    case full(String)
    case path(String)
    case urlPathParam(path: String)
    
    var value: String {
        
        let baseUrl = Constants.baseUrl
        
        switch self {
        case .full(let url):
            return url
            
        case.path(let path):
            return baseUrl + path
            
        case .urlPathParam(let path):
            let fullUrl = "\(baseUrl)\(path)"
            return fullUrl
        }
    }
}

