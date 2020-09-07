//
//  LS_TableViewCell.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 22/7/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit

protocol LS_DataTableViewCellDelegate {
    func removeButtonTappedOnCell(with indexPath: IndexPath)
}

class LS_TableViewCell: UITableViewCell {
    var delegate: LS_DataTableViewCellDelegate?
    @IBOutlet weak var tableView: UITableView!
    static let reuseIdentifier = "LS_TableViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet weak var removeButton: UIButton!
    
    var rows: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.register(UINib(nibName: "LS_TableViewCell", bundle: nil), forCellReuseIdentifier: "LS_TableViewCell")
        tableView.dataSource = self
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        delegate?.removeButtonTappedOnCell(with: indexPath)
    }
}

extension LS_TableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LS_TableViewCell", for: indexPath)
        cell.textLabel?.text = rows[indexPath.row]
        
        return cell
    }
}
