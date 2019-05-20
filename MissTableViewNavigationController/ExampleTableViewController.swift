//
//  ExampleTableViewController.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 20/5/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import Foundation
import UIKit

class ExampleTableViewController: UITableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Shortcut. Will eventually register a cell subclass which then be dequed
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "DefOink \(indexPath.row + 1)"
        return cell
    }
}
