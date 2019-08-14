//
//  ExampleTableViewController.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 20/5/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import Foundation
import UIKit

class ExampleTableViewController: UITableViewController, LS_CellDelegate {
    private var tableData = [LS_Data]()
    var modelController: LS_DataController!
    
    var editView: LS_EditDetailView!
    var detailView: LS_DataDetailView!
    
    // outlet to pass LS_Data between ViewControllers
//    @IBOutlet weak var data: LS_Data!
    
    // vars must be lazy properties if they need to be initialised before self exists. These closures DO NOT retain the captured self
    fileprivate lazy var _addButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add,
                               target: self,
                               action: #selector(handleAddButtonItemTapped))
    }()
    fileprivate lazy var _editButtonItem = self.editButtonItem
    
    override func viewDidLoad() {
        print("hmm")
        
        // load data
        self.loadData()
        
        self.title = "ViewController Title"
        self.navigationItem.leftBarButtonItem = self._addButtonItem
        self.navigationItem.rightBarButtonItem = self._editButtonItem
        
//        if tableData.count < 1 {
//            for index in 0...tableData.count {
//                let newData = LS_Data(name: "Data #\(index)")
//                tableData.insert(newData, at: index)
//            }
//        }
        
        print("initial frame size: \(self.view.frame.size)")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
//        detailView.delegate = self as! LS_BackButtonDelegate// as? LS_DataDetailDelegate
    }
    
    func loadData() {
        if modelController == nil {
            print("WARNING: modelController nil")
            print("tableData has \(tableData.count) elements")
            modelController = LS_DataController()
            
            if tableData.count > 0 {
                modelController.dataStructure = tableData
                print("modelController.dataStructure now has \(modelController.dataStructure.count) elements")
            } else {
                // new dummy header as no tableData exists
                tableData.append(LS_Data(name: "First!"))
                modelController.dataStructure = tableData
            }
        } else {
//            modelController.dataStructure = tableData
            
            tableData = modelController.dataStructure
        }
//        tableView.reloadData()
    }
    
    func getData() -> [LS_Data] {
        return (tableData)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        print("appear hmm")
//
//        self.title = "ViewController Title"
//        self.navigationItem.leftBarButtonItem = self._addButtonItem
//        self.navigationItem.rightBarButtonItem = self._editButtonItem
//
////        for index in 0...tableData.count {
////            let newData = LS_Data(name: "Data #\(index)")
////            tableData.insert(newData, at: index)
////        }
//
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//
//        //        detailView.delegate = self as! LS_BackButtonDelegate// as? LS_DataDetailDelegate
//    }

    
    
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
        
        onCellTouched(sender: cell!, atRow: indexPath.row)
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
//                editView = LS_EditDetailViewController
                self.tableData.append(newData)
//                self.loadData()
                self.tableView.reloadData()
                // TODO: Should be EditDetailViewController
                let destinationEditDetailViewController = LS_EditDetailViewController()
                destinationEditDetailViewController.allData = self.tableData
                destinationEditDetailViewController.editData = newData
                destinationEditDetailViewController.modelController = self.modelController
//                self.tableView.reloadData()
                self.navigationController?.pushViewController(destinationEditDetailViewController, animated: false)
            } else {
                print("error entering or reading text")
            }
            
        }))
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            theTextField = textField
            theTextField?.placeholder = "A whole new string"
        })
        
        self.present(alertController, animated: true, completion: {
//            print("New Item touched, creating a new item with entered name \(theTextField!.text)")
//            navigationController?.pushViewController(descriptionDetailViewController, animated: false)
        })
    }
    
    func updateData(data: LS_Data) {
        print("data.id: \(data.id)")
        if(tableData.contains(where: { $0.id == data.id }) ) {
            print("should update!")
            print("tableData.count: \(tableData.count)")
//            self.loadData()
        } else {
//            print("tableData[0].id: \(tableData[0].id)")
            print("should append -- for id: \(data.id)")
            tableData.append(data)
            print("tableData.count: \(tableData.count)")
//            self.loadData()
        }
    }
    
    func onCellTouched(sender: UITableViewCell, atRow: Int) {
        print("Cell touched at row (\(atRow)), delegating for data")
        let destinationDetailViewController = LS_DataDetailViewController()
        destinationDetailViewController.view.frame = self.view.frame
        
        self.loadData()
        destinationDetailViewController.allData = tableData
        destinationDetailViewController.dataIndex = atRow
        
        navigationController?.pushViewController(destinationDetailViewController, animated: false)
    }
    
    func onCellTouched(sender: UITableViewCell) {
        print("cell touched, ExampleTableViewController")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as? LS_EditDetailViewController
        let index = tableView.indexPathForSelectedRow?.row as! Int
        
//        editViewController!.editData = tableData[index]
        editViewController!.modelController = modelController
    }
}
