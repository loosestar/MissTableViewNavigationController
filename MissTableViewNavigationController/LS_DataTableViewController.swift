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
    var tbController: LS_TabBarController!
    
    func onCellTouched(sender: UITableViewCell) {
        print("cell touched!")
    }
    
    private var tableData = [LS_Data]()
    var modelController: LS_DataController!
    var dataSource: LS_DataTableViewDataSource! = nil {
        didSet {
            dataTableView.reloadData()
        }
    }

    private var initialData: LS_Utilities!
    var dataTableView: LS_DataTableView = LS_DataTableView()
    let cellID = "cellID"
    
    // TODO: specialist views? edit and detail?
    
    fileprivate lazy var _addButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add,
                               target: self,
                               action: #selector(handleAddButtonItemTapped))
    }()
    fileprivate lazy var _editButtonItem: UIBarButtonItem = {//self.editButtonItem
        return UIBarButtonItem(barButtonSystemItem: .edit,
                               target: self,
                               action: #selector(handleEditButtonItemTapped))
    }()
    fileprivate lazy var _doneButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .done,
                               target: self,
                               action: #selector(handleDoneButtonItemTapped))
    }()
    
    @objc func handleAddButtonItemTapped(sender: UIBarButtonItem) {
        print("Display an alert/view/etc to add details of a new item then the item itself to tableData")

        let alertController = UIAlertController(title: "New item", message: "Enter a string", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: nil)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if let userInput = alertController.textFields![0].text {
                print("\"\(userInput)\" entered")
                let newData = LS_Data(name: userInput)
                let newIndex = self.tableData.count
                self.tableData.append(newData)
                self.dataSource.data = self.tableData
                
                // TODO: maybe reloadData()
                self.modelController.dataStructure = self.dataSource.data
                self.loadData()
                
                self.dataTableView.reloadData()
            } else {
                print("error entering or reading text")
            }
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleEditButtonItemTapped(sender: UIBarButtonItem) {
        print("Edit mode?")

        if !self.dataTableView.isEditing {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem = self._doneButtonItem
            self.dataTableView.setEditing(true, animated: true)
        } else {
//            self.navigationItem.leftBarButtonItem?.isEnabled = true
//            self.navigationItem.rightBarButtonItem?.title = "Edit"
//            self.dataTableView.setEditing(false, animated: true)
        }
    }
    
    @objc func handleDoneButtonItemTapped(sender: UIBarButtonItem) {
        print("Done mode?")

        if self.dataTableView.isEditing {
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem = self._editButtonItem
            self.dataTableView.setEditing(false, animated: true)
        } else {
//            self.navigationItem.leftBarButtonItem?.isEnabled = true
//            self.navigationItem.rightBarButtonItem?.title = "Edit"
//            self.dataTableView.setEditing(false, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewWillAppear(true)
        
        self.setupTableView()
        self.tbController = LS_TabBarController()
        tbController.tableDelegate = self
        
        // load data AND SET THE DELEGATE D:
        self.loadData()
        self.dataTableView.delegate = self
        self.dataTableView.reloadData()
        self.dataTableView.beginUpdates()
        self.dataTableView.endUpdates()
        
        self.view = self.dataTableView
        self.view.setNeedsDisplay()
        
//        print("visible cells legitimate now? \(self.dataTableView.visibleCells) -- NO")
    }
    
    // registers a class for the creation of table cells
    func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LS_TableViewCell")
        self.dataTableView = LS_DataTableView()
        self.dataTableView.register(LS_TableViewCell.self, forCellReuseIdentifier: "LS_TableViewCell")
    }
    
    func loadData() {
        if modelController == nil {
            print("WARNING: modelController is nil")
            print("tableData has \(tableData.count) elements")
            
            modelController = self.tbController.modelController //LS_DataController()
            
            if tableData.count > 0 {
                modelController.dataStructure = tableData
                
                if dataSource == nil {
                    dataSource = LS_DataTableViewDataSource(data: tableData, reuseIdentifier: "LS_TableViewCell")
                }
                
                print("modelController.dataStructure now has \(modelController.dataStructure.count) elements")
                
                self.dataTableView.dataSource = dataSource
            } else {
                print("INITIALISING tableData")
                // dummy elements as no tableData exists
                initialData = LS_Utilities.init()
                tableData = initialData.allData()
                dataSource = LS_DataTableViewDataSource(data: tableData, reuseIdentifier: "LS_TableViewCell")
                
                self.dataTableView.dataSource = dataSource
                
                print("dataTableView has \(self.dataTableView.numberOfRows(inSection: 0)) rows")
//                print("dataTableView has \(self.dataTableView.visibleCells.count) visible cells")
                
                if !tableData.isEmpty {
                    modelController.dataStructure = tableData
                    let newIndexPaths:[IndexPath] = (0 ..< modelController.dataStructure.count).map { IndexPath(row: $0, section: 0)}
                    
                    self.dataTableView.reloadData()
                    
                    print("\(self.dataTableView.numberOfRows(inSection: 0)) rows in dataTableView before insertRows with \(newIndexPaths.count) indexPaths")
                    print("\(self.dataTableView.numberOfRows(inSection: 0)) rows in dataTableView after insertRows")
                    
                    print("tableData was not empty, modelController.dataStructure now has \(modelController.dataStructure.count) elements")
                } else {
                    modelController.dataStructure = tableData
                    
                    print("tableData was empty, modelController.dataStructure now has \(modelController.dataStructure.count) elements")
                }
            
//                print("tableView has \(self.dataTableView.visibleCells.count) visible cells")
                print("meanwhile tableView has \(self.dataTableView.numberOfRows(inSection: 0)) rows")
                
                // TODO: TEMPORARY, testing!
                self.title = "ViewController Title"
                self.navigationItem.leftBarButtonItem = self._addButtonItem
                self.navigationItem.rightBarButtonItem = self._editButtonItem
            }
        } else {
            print("Populate the table with known data!")
            
            tableData = modelController.dataStructure
            
            if tableData.count > 0 {
                if dataSource == nil {
                    dataSource = LS_DataTableViewDataSource(data: tableData, reuseIdentifier: "LS_TableViewCell")
                }
                
                print("modelController.dataStructure now has \(modelController.dataStructure.count) elements")
                
                self.dataTableView.dataSource = dataSource
            }
            
            let newIndexPaths:[IndexPath] = (0 ..< modelController.dataStructure.count).map { IndexPath(row: $0, section: 0)}
                                
            self.dataTableView.reloadData()
            
            print("\(self.dataTableView.numberOfRows(inSection: 0)) rows in dataTableView before insertRows with \(newIndexPaths.count) indexPaths")
//                    self.dataTableView.insertRows(at: newIndexPaths, with: .bottom)
            print("\(self.dataTableView.numberOfRows(inSection: 0)) rows in dataTableView after insertRows")
//                    self.dataTableView.reloadData()
            
            print("tableData was not empty, modelController.dataStructure now has \(modelController.dataStructure.count) elements")
            
            self.title = "ViewController Title"
            self.navigationItem.leftBarButtonItem = self._addButtonItem
            self.navigationItem.rightBarButtonItem = self._editButtonItem
        }
    }
    
    func updateData(index: Int) {
        print("this method happily copies data between an edit vc and detail vc. HAPPILY")

//        self.modelController.dataStructure[index] = modifiedData
        
        self.tableData[index] = self.modelController.dataStructure[index]
        print("updated detailData: \(self.modelController.dataStructure[index].name)")

        // TODO: put the modified detailData in the modelController
//        self.saveData(detailData: self.detailData)
    }
    
    func updateDataSource() {
        self.dataSource.data = self.tableData
    }
    
    func saveData(detailData: LS_Data) {
        print("detailData.id: \(detailData.id)")
//        for i in (0...(self.tbController.modelController!.dataStructure.count - 1)) {
//            if self.tbController.modelController.dataStructure[i].id == detailData.id {
//                print("dataStructure and detailData ids DO match\n\t\(self.tbController.modelController.dataStructure[i].id) : \(detailData.id)")
//                print("updating the dataModel at \(i)")
//                print("editData.name: \(detailData.name)")
//
//                self.tbController.modelController.dataStructure[i] = detailData
//                print("data name in modelController: \(self.tbController.modelController.dataStructure[i].name)")
//            } else {
//                print("dataStructure and detailData ids don't match\n\t\(self.tbController.modelController.dataStructure[i].id) : \(detailData.id)")
//            }
//        }
        
        for i in (0...(self.modelController!.dataStructure.count - 1)) {
            if self.modelController.dataStructure[i].id == detailData.id {
                let indexPath: IndexPath = IndexPath(item: i, section: 0)
                
                print("dataStructure and detailData ids DO match\n\t\(self.modelController.dataStructure[i].id) : \(detailData.id)")
                print("updating the dataModel at \(i)")
                print("editData.name: \(detailData.name)")

                self.modelController.dataStructure[i].name = detailData.name
                
                print("data name in modelController: \(self.modelController.dataStructure[i].name)")
                self.dataTableView.reloadData() //reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
            } else {
                print("dataStructure and detailData ids don't match\n\t\(self.modelController.dataStructure[i].id) : \(detailData.id)")
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let tbController = LS_TabBarController()
        
        print("row \(indexPath.row) selected")
//        performSegue(withIdentifier: "LS_DetailSegue", sender: tableView)
        let detailVC = LS_DataDetailViewController()
        detailVC.delegate = self
//        let navigationController = UINavigationController()
//        navigationController.viewControllers = [detailVC]
//        detailVC.modalPresentationStyle = .pageSheet // detail should be fullscreen!
//        detailVC.modelController = modelController
        tbController!.activeIndex = indexPath.row
        detailVC.dataIndex = indexPath.row
//        detailVC.detailData = self.modelController.dataStructure[detailVC.dataIndex]
//        detailVC.detailView = LS_DataDetailView() // detailView or view?
        detailVC.loadData()
        detailVC.tbController = tbController
//        detailVC.prepareView()
//        detailVC.viewWillLayoutSubviews()
        
        detailVC.modalPresentationStyle = .fullScreen
//        self.present(detailVC, animated: true, completion: nil)
//        self.present(navigationController, animated: true, completion: nil)
        
//        detailVC.viewWillLayoutSubviews()
        tbController.addChild(detailVC)
        
//        self.present(detailVC, animated: false, completion: nil)
//        appDelegate.window?.rootViewController = self.tbController
        
        self.navigationController?.pushViewController(tbController, animated: false)
//        self.present(tbController, animated: false, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        print("Editing row \(indexPath.row)")
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler: { (rowAction, tableView, completionHandler)  in
            self.tableData.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.dataSource.data = self.tableData
            self.modelController.dataStructure = self.dataSource.data

            self.tableView.reloadData()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        })
        deleteAction.backgroundColor = .red
        
        let swipeAction: UISwipeActionsConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeAction
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LS_DetailSegue" {
            if let detailViewController = segue.destination as? LS_DataDetailViewController {
                let indexPath = self.tableView.indexPathForSelectedRow!
                let index = indexPath.row
                
//                detailViewController.modelController = self.modelController
                detailViewController.dataIndex = index
                detailViewController.detailData = self.modelController.dataStructure[detailViewController.dataIndex]
            }
        }
    }
}
