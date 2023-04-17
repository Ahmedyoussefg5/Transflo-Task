//
//  NetworkState.swift
//  Transflo Task
//
//  Created by Youssef on 15/04/2023.
//  Copyright © 2022 Youssef. All rights reserved.
//

import Foundation

enum NetworkState<R: BaseResponse> {
    case success(R)
    case fail(MyAppError)
    
    init(_ response: R) {
        if response.isSuccess {
            self = .success(response)
        } else {
            self = .fail(MyAppError.networkError)
        }
    }
}
