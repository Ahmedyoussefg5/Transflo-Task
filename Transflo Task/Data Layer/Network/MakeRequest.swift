//
//  MakeRequest.swift
//  Transflo Task
//
//  Created by Youssef on 15/04/2023.
//  Copyright © 2022 Youssef. All rights reserved.
//

import Foundation

protocol RequestMaker<T>: AnyObject {
    associatedtype T: BaseResponse
    var network: any Network<T> { get }
    func addPathVariables(path: String...) -> Self
    func makeRequest(with body: JsonEncadable?) async -> RequestPublisher<T>
}

extension RequestMaker {
    func makeRequest(with body: JsonEncadable? = nil) async -> RequestPublisher<T> {
        await network
            .withBody(body)
            .asPublisher()
            .eraseToAnyPublisher()
    }
    
    func addPathVariables(path: String...) -> Self {
        network.request.addPathVariables(path: path)
        return self
      }
}
