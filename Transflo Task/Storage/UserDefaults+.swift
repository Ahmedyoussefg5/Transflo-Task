//
//  UserDefaults+.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//


import Foundation

extension UserDefaults {
    @UserDefault(key: "ForecastSearchHistory", defaultValue: [])
    static var forecastSearchHistory: [ForecastSearch]
}
