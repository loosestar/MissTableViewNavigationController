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
    private var tableData = [LS_Data]()
    
    // vars must be lazy properties if they need to be initialised before self exists. These closures DO NOT retain the captured self
    fileprivate lazy var _addButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add,
                               target: self,
                               action: #selector(handleAddButtonItemTapped))
    }()
    fileprivate lazy var _editButtonItem = self.editButtonItem
    
    override func viewDidLoad() {
        print("hmm")
        
        self.title = "ViewController Title"
        self.navigationItem.leftBarButtonItem = self._addButtonItem
        self.navigationItem.rightBarButtonItem = self._editButtonItem
        
        for index in 0...9 {
            let newData = LS_Data(name: "Data #\(index)")
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
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        // disable the add button while editing text, enable it when not editing
        _addButtonItem.isEnabled = !editing    // toggle the editing value each time the edit button is touched
        super.setEditing(editing, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if (self.tableData.count > 0) {
                print("(indexPath: \(indexPath.row))")
                print("num sections in tableView: \(tableView.numberOfSections)")
                print("this section")
                print("tableData has \(self.tableData.count) elements")
                self.tableData.remove(at: indexPath.row)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        print("selected row \(indexPath.row) with content: \(String(describing: cell?.textLabel?.text))")
    }
 
    @objc func handleAddButtonItemTapped(sender: UIBarButtonItem) {
        print("Add add add!")
        
        var theTextField: UITextField?
        let alertController = UIAlertController(title: "New item", message: "Enter a string", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok tapped")
            
            if let userInput = theTextField!.text {
                print("\"\(userInput)\" entered")
                let newData = LS_Data(name: userInput)
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
}
