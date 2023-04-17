//
//  ForecastTableDataSource.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//

import UIKit

class ForecastTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var list: [ForecastSearch] = []
    private var tableView: UITableView?
    
    var selection: ((_ type: ForecastSearch) -> ())?
    
    init(tableView: UITableView?) {
        self.tableView = tableView
        super.init()
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorColor = .clear
    }
    
    func reload(with list: [ForecastSearch] = []) {
        self.list = list
        tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        cell?.textLabel?.text = list[indexPath.row].disc
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(list[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .zero
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .zero
    }
}
