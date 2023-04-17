//
//  ForecastRepository.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//

import Foundation
import Combine

protocol ForecastRepository {
    func search(body: JsonEncadable) async -> AnyPublisher<NetworkState<ForecastResponse>, Never>
}

class ForecastRepositoryImplementation: ForecastRepository {
        
    private let dataSource: ForecastDataSource
    
    init(dataSource: ForecastDataSource) {
        self.dataSource = dataSource
    }
    
    func search(body: JsonEncadable) async -> AnyPublisher<NetworkState<ForecastResponse>, Never> {
        await dataSource
            .forecastRequest
            .makeRequest(with: body)
            .eraseToAnyPublisher()
    }
}
