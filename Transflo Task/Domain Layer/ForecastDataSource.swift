//
//  ForecastDataSource.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//

import Foundation

protocol ForecastDataSource {
    var forecastRequest: any RequestMaker<ForecastResponse> { get }
}

class ForecastDataSourceImplementation: ForecastDataSource {
    
    init(forecastRequest: any RequestMaker<ForecastResponse>) {
        self.forecastRequest = forecastRequest
    }
    
    var forecastRequest: any RequestMaker<ForecastResponse>
}
