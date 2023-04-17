//
//  ForecastResponse.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//

import Foundation

// MARK: - Welcome
struct ForecastResponse: BaseResponse {
    let message: Int?
    let cod: String?
    let cnt: Int?
    let list: [List]?
    let city: City?
}

// MARK: - City
struct City: Codable {
    let sunset: Int?
    let country: String?
    let id: Int?
    let coord: Coord?
    let population, timezone, sunrise: Int?
    let name: String?
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double?
}

// MARK: - List
struct List: Codable {
    let clouds: Clouds?
    let wind: Wind?
    let dt: Int?
    let dtTxt: String?
    let main: MainClass?
    let weather: [Weather]?
    let pop: Int?
    let sys: Sys?
    let visibility: Int?

    enum CodingKeys: String, CodingKey {
        case clouds, wind, dt
        case dtTxt = "dt_txt"
        case main, weather, pop, sys, visibility
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - MainClass
struct MainClass: Codable {
    let humidity: Int?
    let feelsLike, tempMin, tempMax, temp: Double?
    let pressure: Int?
    let tempKf: Double?
    let seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp, pressure
        case tempKf = "temp_kf"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main: String?
    let icon: String?
    let description: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
