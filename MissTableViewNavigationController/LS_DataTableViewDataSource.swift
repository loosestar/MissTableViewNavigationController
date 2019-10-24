//
//  LS_DataTableViewDataSource.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 23/9/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import Foundation
import UIKit

class LS_DataTableViewDataSource: NSObject, UITableViewDataSource {
    typealias CellConfigurator = (LS_Data, UITableViewCell) -> Void
    
    var data: [LS_Data]
    
    private let reuseIdentifier: String
//    private let cellConfigurator: CellConfigurator
    
    init(data: [LS_Data], reuseIdentifier: String/*, cellConfigurator: @escaping CellConfigurator*/) {
        self.data = data
        self.reuseIdentifier = reuseIdentifier
//        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    
//        cellConfigurator(cellData, cell)
        
        cell.textLabel?.text = cellData.name
        cell.detailTextLabel?.text = cellData.description
        
        return cell
    }
}
