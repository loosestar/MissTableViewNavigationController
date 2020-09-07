//
//  LS_TableViewCell.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 22/7/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit

class LS_TableViewCell: UITableViewCell {
    @IBOutlet weak var tableView: UITableView!
    
    var rows: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.register(UINib(nibName: "LS_TableViewCell", bundle: nil), forCellReuseIdentifier: "LS_TableCell")
        tableView.dataSource = self
    }
}

extension LS_TableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LS_TableCell", for: indexPath)
        cell.textLabel?.text = rows[indexPath.row]
        
        return cell
    }
}
