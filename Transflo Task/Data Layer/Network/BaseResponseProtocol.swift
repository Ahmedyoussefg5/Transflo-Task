//
//  BaseResponseProtocol.swift
//  Transflo Task
//
//  Created by Youssef on 15/04/2023.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation

protocol BaseResponse: Codable {
    var isSuccess: Bool { get }
    var cod: String? { get }
}

extension BaseResponse {
     var isSuccess: Bool {
        return (cod == "200")
    }
}
