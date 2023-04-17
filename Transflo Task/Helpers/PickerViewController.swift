//
//  PickerViewController.swift
//  Transflo Task
//
//  Created by Youssef on 16/04/2023.
//  Copyright © 2023 youssef. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rowsData[o: row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rowsData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let item = rowsData[o: row] {
            selectedItem?(item)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    var rowsData: [String]
    
    var selectedItem: ((_ item: String) -> ())?
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .clear
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    init(itemsToShow: [String]) {
        rowsData = itemsToShow
        super.init(nibName: nil, bundle: nil)
        
        if itemsToShow.isEmpty {
            dismiss(animated: false, completion: nil)
            return
        }
        
        pickerView.reloadAllComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        let dismisslaView = UIView()
        view.addSubview(dismisslaView)
        dismisslaView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismisslaView.topAnchor.constraint(equalTo: view.topAnchor),
            dismisslaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dismisslaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dismisslaView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        dismisslaView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMe)))
        
        let pickerViewBackView = UIView()
        pickerViewBackView.backgroundColor = .gray
        view.addSubview(pickerViewBackView)
        pickerViewBackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerViewBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pickerViewBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerViewBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerViewBackView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        pickerViewBackView.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: pickerViewBackView.topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: pickerViewBackView.bottomAnchor),
            pickerView.leadingAnchor.constraint(equalTo: pickerViewBackView.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: pickerViewBackView.trailingAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let item = rowsData.first {
            selectedItem?(item)
        }
    }
    
    @objc
    private func dismissMe() {
        dismiss(animated: true, completion: nil)
    }
}

extension Collection {
    subscript(o index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
