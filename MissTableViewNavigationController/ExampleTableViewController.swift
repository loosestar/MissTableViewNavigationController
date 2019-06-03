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
    private var tableData = [LS_Data]() // was [String]()
    
    override func viewDidLoad() {
        print("hmm")
        
        let leftButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(ExampleTableViewController.handleNewButtonItemTapped))
        let rightButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: nil, action: #selector(ExampleTableViewController.handleEditButtonItemTapped))
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        for index in 0...9 {
            let newData = LS_Data(id: tableData.count, name: "Data #\(index)")
            tableData.insert(newData, at: index)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Shortcut. Will eventually register a cell subclass which then be dequed
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.textLabel?.text = "DefOink \(indexPath.row + 1)"
        if tableData.count > indexPath.row {
            cell.textLabel?.text = tableData[indexPath.row].name
        }
        return cell
    }
    
    var rightBarButtonItem: UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: nil)
        barButtonItem.tintColor = UIColor.blue
        return barButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        // disable the add button while editing text, enable it when not editing
        self.navigationItem.leftBarButtonItem?.isEnabled = !editing
        super.setEditing(editing, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // TODO: remove the object on this row here
            // DEBUG
            if (self.tableData.count > 0) {
                print("(indexPath: \(indexPath.row))")
                print("num sections in tableView: \(tableView.numberOfSections)")
                print("this section")
                print("tableData has \(self.tableData.count) elements")
                self.tableData.remove(at: indexPath.row) //(self.tableData[indexPath.row])
                print("now tableData has \(self.tableData.count) elements")
                print("numRows in section: \(self.tableView.numberOfRows(inSection: tableView.numberOfSections - 1))")
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.reloadData()
                self.tableView.endUpdates()
                print("numRows in section: \(self.tableView.numberOfRows(inSection: tableView.numberOfSections - 1))")
                self.tableView.reloadData()
                print("numRows in section: \(self.tableView.numberOfRows(inSection: tableView.numberOfSections - 1))")
            }
        }
    }
 
    @objc func handleNewButtonItemTapped(sender: UIBarButtonItem) {
        print("Add add add!")
        
        var theTextField: UITextField?
        let alertController = UIAlertController(title: "New item", message: "Enter a string", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok tapped")
            
            if let userInput = theTextField!.text {
                print("\"\(userInput)\" entered")
                let newData = LS_Data(id: self.tableData.count, name: userInput)
//                newData.name = userInput
                self.tableData.append(newData)
                self.tableView.reloadData()
            } else {
                print("error entering or reading text")
            }
            
        }))
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            theTextField = textField
            theTextField?.placeholder = "A whole new string"
        })
        
        self.present(alertController, animated: true, completion: {
//            print("Entered \(theTextField?.text! ?? "null")")
//            tableData.append(theTextField!.text(String))"
        })
    }
    
    @objc func handleEditButtonItemTapped(sender: UIBarButtonItem) {
        print("Edit edit edit!")
        
        self.setEditing(true, animated: true)
    }
}
