//
//  AppError.swift
//  Transflo Task
//
//  Created by Youssef on 15/04/2023.
//  Copyright © 2021 Youssef. All rights reserved.
//

import Foundation

protocol AppError: LocalizedError {
    var validatorErrorAssociatedMessage: String { get }
}

enum MyAppError: AppError {
    
    case networkError
    case businessError(String)
    case basicError
    
     var validatorErrorAssociatedMessage: String {
        switch self {
        case .networkError:
            return "Network Error"
        case .businessError( let error):
            return error
        case .basicError:
            return "Something wrong happened, try again later."
        }
    }
}
