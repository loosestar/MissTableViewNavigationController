//
//  LS_DataTableViewDataSource.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 10/9/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import Foundation
import UIKit

class LS_DataTableViewDataSource<LS_Data>: LS_DataTableView {
    typealias CellConfigurator = (LS_Data, LS_TableViewCell) -> Void
    
    var data: [LS_Data]
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    init(data: [LS_Data], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.data = data
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
}
