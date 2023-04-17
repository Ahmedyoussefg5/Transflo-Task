//
//  SearchWithLatLngBody.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//

import Foundation

struct SearchWithLatLngBody: JsonEncadable {
    let lat: Double
    let lon: Double
    let appid = Constants.apiKey
}

struct SearchWithZipCodeBody: JsonEncadable {
    let zip: String
    let appid = Constants.apiKey
}

struct SearchWithCityNameBody: JsonEncadable {
    let cityName: String
    let appid = Constants.apiKey
    
    var json: [String : Any] {
        return [
            "q": cityName,
            "appid": appid
        ]
    }
}
