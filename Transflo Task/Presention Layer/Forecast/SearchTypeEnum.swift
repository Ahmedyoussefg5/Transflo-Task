//
//  SearchTypeEnum.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//

import Foundation

enum SearchType: String, CaseIterable {
    case cityName = "City Name"
    case zipCode = "Zip Code"
    case latitudeLongitude = "Latitude/Longitude"
    case currentLocation = "Current Location"
}

enum ForecastSearch: Codable {
    case cityName(name: String)
    case zipCode(code: String)
    case latitudeLongitude(lat: Double, lng: Double)
    case currentLocation(lat: Double, lng: Double)
    
    var disc: String {
        switch self {
        case .cityName(let name):
            return "Search with \(name)"
        case .zipCode(let code):
            return "Search with \(code)"
        case .latitudeLongitude(let lat, let lng):
            return "Search with \(lat), \(lng)"
        case .currentLocation:
            return "Search with current Location"
        }
    }
}
