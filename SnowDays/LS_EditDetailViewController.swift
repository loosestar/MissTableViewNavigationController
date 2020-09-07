//
//  LS_EditDetailViewController.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 21/7/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit

class LS_EditDetailViewController: UITableViewController, UITextFieldDelegate, LS_BackButtonDelegate {
    var editView: LS_EditDetailView!
    var editData: LS_Data!
    var allData = [LS_Data]()
    
    var modelController: LS_DataController! = LS_DataController()
    
    @IBOutlet var editName: String?
    @IBOutlet var textField: UITextField!
    
    // vars must be lazy properties if they need to be initialised before self exists. These closures DO NOT retain the captured self
    fileprivate lazy var _cancelButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleCancelButtonTapped))
    }()
    
    fileprivate lazy var _saveButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.done, target: self, action: #selector(handleSaveButtonTapped))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
//        editData = allData[]
        
        textField = UITextField()
        editView = LS_EditDetailView()
        
        editName = editData?.name
        textField.delegate = self
        textField.text = editName
        
//        self.loadData()
        
        self.navigationItem.leftBarButtonItem = _cancelButtonItem
        self.title = "Hmm Edit (\(editName))"
        self.navigationItem.rightBarButtonItem = _saveButtonItem
        
//        editView = LS_EditDetailView()
        self.view = editView
        self.view.addSubview(textField)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // experimenting with a "name" row
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        let cell: LS_TableViewCell = tableView.dequeueReusableCell(withIdentifier: "LS_TableCell") as! LS_TableViewCell
//        let detailData: LS_EditDetailView = editData
        
        // Cells un EditDetailView ARE NOT LS_TableViewCells, rather they're there own beasts. Default UITableViewCells should work too
        let cell: UITableViewCell = UITableViewCell()
        
        textField = UITextField(frame: CGRect(x: 20, y: 0, width: self.view.frame.width, height: 20))
        textField.delegate = self
        textField.placeholder = "enter text here"
        cell.addSubview(textField)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        print("selected row \(indexPath.row) with content: \(String(describing: cell?.textLabel?.text))")
        
//        onCellTouched(sender: cell!)
    }
    
    func loadData() {
        if modelController == nil {
            print("WARNING: modelController nil")
            print("allData has \(allData.count) elements")
//            modelController = LS_DataController()
            
            modelController.dataStructure = allData
        } else {
            allData = modelController.dataStructure
        }
        //        tableView.reloadData()
    }
    
    @objc func handleCancelButtonTapped() {
        print("cancel changes/additions (\(textField.text))")
        
        let destinationTableViewController = ExampleTableViewController()
        self.navigationController?.pushViewController(destinationTableViewController, animated: false)
    }
    
    @objc func handleSaveButtonTapped() {
        print("save changes/additions -- for id: \(editData?.id)")
        
        if (editData != nil) {
            let destinationTableViewController = ExampleTableViewController()
            // update data before segue to the destination
//            destinationTableViewController.loadData
            destinationTableViewController.updateData(data: editData!)
            destinationTableViewController.modelController = self.modelController
            self.navigationController?.pushViewController(destinationTableViewController, animated: false)
        } else {
            print("eek! no data to save")
            let destinationTableViewController = ExampleTableViewController()
            self.navigationController?.pushViewController(destinationTableViewController, animated: false)
        }
    }
    
    func onBackButtonTouched(sender: UIButton) {
        print("back button touched")
    }
}
