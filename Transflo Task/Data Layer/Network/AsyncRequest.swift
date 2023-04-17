//
//  AsyncRequest.swift
//  Transflo Task
//
//  Created by Youssef on 15/04/2023.
//  Copyright © 2022 Youssef. All rights reserved.
//

import Foundation
import Alamofire
import Combine

typealias RequestPublisher<T: BaseResponse> = AnyPublisher<NetworkState<T>, Never>

protocol Network<T>: AnyObject {
    associatedtype T: BaseResponse
    var request: RequestReusable { get }
    func asPublisher() async -> RequestPublisher<T>
    func withBody(_ body: JsonEncadable?) -> Self
}

class AsyncRequest<T: BaseResponse>: Network {

    var request: RequestReusable

    private lazy var interceptor = AppRequestInterceptor()

    init(request: RequestReusable) {
        self.request = request
    }

    private lazy var sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        return Session(configuration: configuration, interceptor: interceptor)
    }()

    func withBody(_ body: JsonEncadable?) -> Self {
        self.request.body = body
        return self
    }

    fileprivate func handleNetworkResult(_ response: DataResponse<T, AFError>, promise: (Result<NetworkState<T>, Never>) -> Void) {
        switch response.result {
        case .success(let model):
            let state = NetworkState<T>(model)
            promise(.success(state))
        case .failure(let error):
            debugPrint("Model Name: \(String(describing: T.self)) has request error", error.asAFError?.errorDescription, error.localizedDescription, error.failureReason, error.localizedDescription)
            promise(.success(.fail(MyAppError.networkError)))
        }
    }

    @discardableResult
    func asPublisher() async -> RequestPublisher<T> {
        Future {[weak self] promise in
            guard let self else {
                promise(.success(.fail(MyAppError.networkError)))
                return
            }
            self.sessionManager
                .request(self.request)
                .responseDecodable(of: T.self, completionHandler: { response in
                    self.handleNetworkResult(response, promise: promise)
                })
        }
        .eraseToAnyPublisher()
    }
}
