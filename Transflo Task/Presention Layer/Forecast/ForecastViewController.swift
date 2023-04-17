//
//  ForecastViewController.swift
//  Transflo Task
//
//  Created by Youssef on 16/04/2023.
//

import UIKit
import Combine

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var searchTypeTextField: UITextField!
    @IBOutlet weak var searchTypeButton: UIButton!
    
    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let viewModel: ForecastViewModel
    private let locationManger = LocationManger()
    private lazy var tableDataSource = ForecastTableDataSource(tableView: historyTableView)
    
    private var bag = Set<AnyCancellable>()
    
    private var selectedSearchType: SearchType = .currentLocation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sink()
        reloadSearchList()
        locationManger.checkAuthorizationStatus()
        historyTableView.delegate = tableDataSource
        historyTableView.dataSource = tableDataSource
    }
    
    @IBAction func searchTypeAction(_ sender: Any) {
        let picker = PickerViewController(itemsToShow: SearchType.allCases.map({ $0.rawValue }))
        picker.selectedItem = {[weak self] item in
            self?.selectedSearchType = SearchType(rawValue: item) ?? .cityName
            self?.searchTypeTextField.placeholder = item
            self?.searchTypeButton.setTitle("Search with: \(item)", for: .normal)
        }
        present(picker, animated: true)
    }
    
    @IBAction func searchAction(_ sender: Any) {
        switch selectedSearchType {
        case .cityName:
            Task {
               await viewModel.search(with: .cityName(name: searchTypeTextField.text ?? ""))
            }
        case .zipCode:
            Task {
               await viewModel.search(with: .zipCode(code: searchTypeTextField.text ?? ""))
            }
        case .latitudeLongitude:
            Task {
                await viewModel.search(with: .currentLocation(lat: locationManger.userLatitude, lng: locationManger.userLongitude))
            }
        case .currentLocation:
            Task {
                await viewModel.search(with: .currentLocation(lat: locationManger.userLatitude, lng: locationManger.userLongitude))
            }
        }
    }
    
    private func sink() {
        viewModel.$weather
            .sink {[weak self] weather in
                DispatchQueue.main.async {
                    self?.weatherLabel.text = weather
                    self?.reloadSearchList()
                }
        }.store(in: &bag)
    }
    
    private func reloadSearchList() {
        tableDataSource.reload(with: UserDefaults.forecastSearchHistory)
    }
}
