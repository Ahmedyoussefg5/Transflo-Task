//
//  ForecastUseCase.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//

import Foundation
import Combine

class ForecastUseCase {
    
    private var bag = Set<AnyCancellable>()
    
    let repo: ForecastRepository
    
    init(repo: ForecastRepository) {
        self.repo = repo
    }
    
    fileprivate func handle(_ result: NetworkState<ForecastResponse>) -> Result<ForecastScreenData, Error> {
        switch result {
        case .success(let response):
            if let weather = response.list?.first?.weather?.first?.description {
                return .success(ForecastScreenData(weather: weather))
            } else {
                return .failure(MyAppError.basicError)
            }
        case .fail(let error):
            return .failure(error)
        }
    }
    
    func validate(input: String?) throws -> String {
        if let input, !input.isEmpty {
            return input
        } else {
            throw MyAppError.businessError("Please enter valid input")
        }
    }
    
    func search(with type: ForecastSearch) async -> Result<ForecastScreenData, Error> {
        switch type {
        case .cityName(let name):
            do {
                let cityName = try validate(input: name)
                return await search(body: SearchWithCityNameBody(cityName: cityName), forecastSearch: type)
            } catch {
                return .failure(error)
            }
        case .zipCode(let code):
            do {
                let code = try validate(input: code)
                return await search(body: SearchWithZipCodeBody(zip: code), forecastSearch: type)
            } catch {
                return .failure(error)
            }
        case .latitudeLongitude(let lat, let lng):
            return await search(body: SearchWithLatLngBody(lat: lat, lon: lng), forecastSearch: type)
        case .currentLocation(let lat, let lng):
            return await search(body: SearchWithLatLngBody(lat: lat, lon: lng), forecastSearch: type)
        }
    }
    
    func search(body: JsonEncadable, forecastSearch: ForecastSearch) async -> Result<ForecastScreenData, Error> {
        save(forecastSearch: forecastSearch)
        let result = await repo
            .search(body: body)
            .singleOutput(with: &bag)
        return handle(result)
    }
    
    func save(forecastSearch: ForecastSearch) {
        var historyList = UserDefaults.forecastSearchHistory
        historyList.insert(forecastSearch, at: 0)
        UserDefaults.forecastSearchHistory = Array(historyList.prefix(5))
    }
}
