//
//  LS_DataDetailViewController.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 17/7/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit

class LS_DataDetailViewController: UIViewController, LS_BackButtonDelegate {
    var detailView: LS_DataDetailView!
    var allData: [LS_Data]?
    var dataIndex: Int = -1
    
    var modelController: LS_DataController!
    
    fileprivate lazy var _editButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleEditButtonTapped))
    }()
    
    @IBOutlet var data_name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        
        data_name = allData?[dataIndex].name
        
        self.title = "Hmm"
        self.navigationItem.rightBarButtonItem = _editButtonItem
        
        detailView = LS_DataDetailView()
        self.view = detailView        
        
        detailView.delegate = self
    }
    
    func loadData() {
        if modelController == nil {
            print("WARNING: modelController nil")
            if allData == nil {
                print("WARNING: allData is also nil")
                
                // giving allData a dummy value for now, will eventually load from a plist
                allData?.append(LS_Data(name: "First"))
                
            } else {
                print("allData has \(allData?.count) elements")
//            modelController = LS_DataController()
            
                modelController.dataStructure = allData!
            }
        } else {
            allData = modelController.dataStructure
        }
        //        tableView.reloadData()
    }
    
    func onBackButtonTouched(sender: UIButton) {
        print("back button touched")
    }
    
    @objc func handleEditButtonTapped() {
        print("edit current view with id: \(allData?[dataIndex].id)")
        
        if (allData != nil) {
            let destinationEditViewController = LS_EditDetailViewController()
            destinationEditViewController.editData = allData?[dataIndex]
            destinationEditViewController.modelController = self.modelController
            self.navigationController?.pushViewController(destinationEditViewController, animated: false)
        } else {
            print("eek! no data to edit")
            let destinationEditViewController = LS_EditDetailViewController()
            self.navigationController?.pushViewController(destinationEditViewController, animated: false)
        }
    }
}
