//
//  HomeViewController.swift
//  Transflo Task
//
//  Created by Youssef on 15/04/2023.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func openForecast(_ sender: Any) {
        let dataSource = ForecastDataSourceImplementation(forecastRequest: ForecastRequest())
        let repo = ForecastRepositoryImplementation(dataSource: dataSource)
        let useCase = ForecastUseCase(repo: repo)
        let viewModel = ForecastViewModel(useCase: useCase)
        let vc = ForecastViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openCurrentWeather(_ sender: Any) {
        
    }
    
}
