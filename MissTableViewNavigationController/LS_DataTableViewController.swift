//
//  LS_DataTableViewController.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 14/8/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import Foundation
import UIKit

class LS_DataTableViewController: UITableViewController, LS_DataTableViewCellDelegate {
    func onCellTouched(sender: UITableViewCell) {
        print("cell touched!")
    }
    
    private var tableData = [LS_Data]() //{
//        didSet {
//            tableView.reloadData()
//        }
//    }
    var modelController: LS_DataController!
    var dataSource: LS_DataTableViewDataSource! = nil {
        didSet {
            dataTableView.reloadData()
        }
    }
    private var initialData: LS_Utilities!
//    var dataTableView: UITableView = UITableView()
    var dataTableView: LS_DataTableView = LS_DataTableView()
    let cellID = "cellID"
    
    // TODO: specialist views? edit and detail?
    
    fileprivate lazy var _addButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add,
                               target: self,
                               action: #selector(handleAddButtonItemTapped))
    }()
    fileprivate lazy var _editButtonItem: UIBarButtonItem = self.editButtonItem
//        return UIBarButtonItem(barButtonSystemItem: .edit,
//                               target: self,
//                               action: #selector(handleEditButtonItemTapped))
//    }()
    
    @objc func handleAddButtonItemTapped(sender: UIBarButtonItem) {
        print("Display an alert/view/etc to add details of a new item then the item itself to tableData")
        
//        var theTextField: UITextField?
        let alertController = UIAlertController(title: "New item", message: "Enter a string", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: nil)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if let userInput = alertController.textFields![0].text {
                print("\"\(userInput)\" entered")
                let newData = LS_Data(name: userInput)
                let newIndex = self.tableData.count
                self.tableData.append(newData)
                self.dataSource.data = self.tableData
//                self.dataTableView.dataSource = self.dataSource
                
                self.dataTableView.reloadData()
//                self.dataTableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
//                self.dataTableView.reloadData()
            } else {
                print("error entering or reading text")
            }
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
//    @objc func handleEditButtonItemTapped(sender: UIBarButtonItem) {
//        print("Edit mode?")
//
//        if !self.dataTableView.isEditing {
//            self.navigationItem.leftBarButtonItem?.isEnabled = false
//            self.navigationItem.rightBarButtonItem?.title = "Done"
//            self.dataTableView.setEditing(true, animated: true)
//        } else {
//            self.navigationItem.leftBarButtonItem?.isEnabled = true
//            self.navigationItem.rightBarButtonItem?.title = "Edit"
//            self.dataTableView.setEditing(false, animated: true)
//        }
//    }
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        super.viewWillAppear(true)
        
        // setup tableView
        self.setupTableView()
        
        // load data AND SET THE DELEGATE D:
        self.loadData()
        self.dataTableView.delegate = self
        self.dataTableView.reloadData()
        
        self.view = dataTableView
        self.view.setNeedsDisplay()
    }
    
    // registers a class for the creation of table cells
    func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LS_TableViewCell")
        self.dataTableView = LS_DataTableView()
        self.dataTableView.register(LS_TableViewCell.self, forCellReuseIdentifier: "LS_TableViewCell")
//        self.dataTableView.allowsSelectionDuringEditing = true
//        self.dataTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
//        self.dataTableView.reloadData()
//        self.tableView = self.dataTableView
//        self.tableView = ExampleTableView()
    }
    
    func loadData() {
        if modelController == nil {
            print("WARNING: modelController is nil")
            print("tableData has \(tableData.count) elements")
            
            modelController = LS_DataController()
            
            if tableData.count > 0 {
                modelController.dataStructure = tableData
                
                if dataSource == nil {
                    dataSource = LS_DataTableViewDataSource(data: tableData, reuseIdentifier: "LS_TableViewCell")
                }
                
                print("modelController.dataStructure now has \(modelController.dataStructure.count) elements")
                
                self.dataTableView.dataSource = dataSource
            } else {
                // dummy elements as no tableData exists
                initialData = LS_Utilities.init()
                tableData = initialData.allData()
                dataSource = LS_DataTableViewDataSource(data: tableData, reuseIdentifier: "LS_TableViewCell")
                
                self.dataTableView.dataSource = dataSource
                
//                modelController.dataStructure = tableData
//                print("modelController.dataStructure now has \(modelController.dataStructure.count) dummy elements")
                print("dataTableView has \(self.dataTableView.numberOfRows(inSection: 0)) rows")
                print("dataTableView has \(self.dataTableView.visibleCells.count) visible cells")
                
                if !tableData.isEmpty {
                    modelController.dataStructure = tableData
                    let newIndexPaths:[IndexPath] = (0 ..< modelController.dataStructure.count).map { IndexPath(row: $0, section: 0)}
                    
                    print("\(self.dataTableView.numberOfRows(inSection: 0)) rows in dataTableView before insertRows with \(newIndexPaths.count) indexPaths")
//                    self.dataTableView.insertRows(at: newIndexPaths, with: .bottom)
                    print("\(self.dataTableView.numberOfRows(inSection: 0)) rows in dataTableView after insertRows")
//                    self.dataTableView.reloadData()
                    
                    print("modelController.dataStructure now has \(modelController.dataStructure.count) elements")
                } else {
                    modelController.dataStructure = tableData
                    
                    print("modelController.dataStructure now has \(modelController.dataStructure.count) elements")
                }

//                self.dataTableView.beginUpdates()
//                self.dataTableView.insertRows(at: newIndexPaths, with: .automatic)     //insertRows(at: newIndexPaths, with: .bottom)

//                DispatchQueue.main.async {
//                print("\(self.dataTableView.numberOfRows(inSection: 0)) rows in dataTableView before insertRows with \(newIndexPaths.count) indexPaths")
//                    self.dataTableView.insertRows(at: newIndexPaths, with: .bottom)
//                print("\(self.dataTableView.numberOfRows(inSection: 0)) rows in dataTableView after insertRows")
//                    self.dataTableView.reloadData()
//                    self.dataTableView.performBatchUpdates(self.reloadInputViews, completion: nil)
//                }
            
//                self.dataTableView.endUpdates()
            
                print("tableView has \(self.dataTableView.visibleCells.count) visible cells")
                print("meanwhile tableView has \(self.dataTableView.numberOfRows(inSection: 0)) rows")
                
//                self.tableView.reloadData()
                
                // TODO: TEMPORARY, testing!
                self.title = "ViewController Title"
                self.navigationItem.leftBarButtonItem = self._addButtonItem
                self.navigationItem.rightBarButtonItem = self._editButtonItem
                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if self.isEditing == false {
            super.setEditing(editing, animated: true)
            self.tableView.setEditing(editing, animated: true)
            print("editing ON")
        } else {
            super.setEditing(editing, animated: true)
            self.tableView.setEditing(editing, animated: true)
            print("editing OFF")
        }
    }
    
    func removeButtonTappedOnCell(with indexPath: IndexPath) {
        print("yo!")
        self.tableData.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let label = UILabel()
        label.text = self.tableData[indexPath.row].name
        
//        let cell = LS_TableViewCell(style: .default, reuseIdentifier: "LS_TableViewCell")
//        cell.titleLabel = label
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LS_TableViewCell", for: indexPath) as! LS_TableViewCell
        cell.textLabel?.text = label.text
        cell.removeButton.tag = indexPath.row
        cell.delegate = self as LS_DataTableViewCellDelegate
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row \(indexPath.row) selected")
    }
    
    override func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        print("Editing row \(indexPath.row)")
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        print("Editing row \(indexPath.row)")
//        
//        if indexPath.row == 1 {
//            return false
//        }
//        
//        return true
//    }
    
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
////        if (self.tableView.isEditing) {
//        return UITableViewCell.EditingStyle.delete
////        } else {
////            return UITableViewCell.EditingStyle.none
////        }
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete", handler: { (rowAction, indexPath) in
            self.tableData.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.dataSource.data = self.tableData
//            self.modelController.dataStructure = self.tableData
//            self.dataTableView.reloadData()
            self.tableView.reloadData()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        })
        deleteAction.backgroundColor = .red
        
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("delete time!")
            // remove the row data from the data source
            self.tableData.remove(at: indexPath.row)
//            self.dataTableView.dataSource = dataSource
            
            // delete the row from TableView
//            self.dataTableView.beginUpdates()
            self.dataTableView.deleteRows(at: [indexPath], with: .fade)
            self.dataTableView.reloadData()
//            self.dataTableView.endUpdates()
        } else {
            print("editing style is not delete?")
        }
    }
}
