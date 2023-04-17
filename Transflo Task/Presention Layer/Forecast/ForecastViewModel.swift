//
//  ForecastViewModel.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//

import Foundation
import Combine

class ForecastViewModel {
    
    init(useCase: ForecastUseCase) {
        self.useCase = useCase
    }
    
    private let useCase: ForecastUseCase
    
    @Published var weather: String?
    
    private var bag = Set<AnyCancellable>()
    
    fileprivate func handle(_ result: Result<ForecastScreenData, Error>) {
        switch result {
        case .success(let screenData):
            weather = screenData.weather
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func search(with forecastSearch: ForecastSearch) async {
      let result = await useCase.search(with: forecastSearch)
        handle(result)
    }
}
