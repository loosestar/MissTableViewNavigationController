//
//  LS_DataDetailViewController.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 17/7/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit
import SwiftUI

//protocol LS_EditDataProtocol {
//    var data: LS_Data {get set}
//
//    func copyData()
//}

class LS_DataDetailViewController: UIViewController, UIActivityItemSource, UINavigationControllerDelegate, LS_BackButtonDelegate {
    weak var delegate: LS_DataTableViewController!
//    weak var detailDelegate: LS_DataDetailViewController!
    var detailView: LS_DataDetailView!
    var allData: [LS_Data]?
    var detailData: LS_Data!
    var dataIndex: Int! // TODO: NEEDS A DEFAULT VALUE in case of screw ups
    
//    var modelController: LS_DataController!
    
    var destinationEditViewController: LS_EditDetailViewController!
    
    var tbController: LS_TabBarController! //= LS_TabBarController()
    let _navigationBar: UINavigationBar = UINavigationBar(frame: CGRect.zero) //(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 44))
    
    fileprivate lazy var _editButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleEditButtonTapped))
    }()
    
    @IBOutlet var data_name: String?
    
    // to add a navbar
    override func viewWillLayoutSubviews() {
        let width = self.view.frame.width
        let height = self.view.frame.height/* - 44.0*/
        
        _navigationBar.frame = CGRect(x: 0.0, y: 0.0, width: width, height: 44.0 /*height*/)
//        self.view.addSubview(navigationBar)
        
        let navigationItem = UINavigationItem(title: "DetailView")
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(handleDoneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = _editButtonItem
        
        _navigationBar.setItems([navigationItem], animated: false)
        self.view.addSubview(_navigationBar)
        self.view.setNeedsLayout()
        
        print("layoutsubviews of ddvc")
//        super.navigationItem.backBarButtonItem =
//        super.navigationItem.title = "DetailView"
//        super.navigationItem.setLeftBarButton(_editButtonItem, animated: false)
//        super.navigationItem.setRightBarButton(doneButton, animated: false)
        
//        let tbController: LS_TabBarController = LS_TabBarController()
//        tbController.view.frame = CGRect(x: 0.0, y: height - 44, width: width, height: 44)
//        tbController.view.isUserInteractionEnabled = true
//        tbController.activeIndex = dataIndex
//        self.view.addSubview(tbController.view)
        
//        if let tbInteraction = self.tabBarController {
//            tbInteraction.selectedIndex = 1
//            let setting = tbInteraction.viewControllers![4]
//            tbController.tabBarController(tbController, didSelect: setting)
//        }
        
//        let tabBarController: LS_TabBarController = LS_TabBarController()
//        let tabBar = tabBarController.view
//        self.view.addSubview(tabBar!)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setItems(_navigationBar.items, animated: false)

        print("viewDidLoad LS_DataDetailViewController")
        
        self.detailView = LS_DataDetailView()
        self.loadData()

        if detailData != nil { // hmmmmmm?
            data_name = detailData.name //allData?[dataIndex].name
            print("data_name: \(data_name)")

    //        self.title = "Hmm"
    //        self.navigationItem.rightBarButtonItem = _editButtonItem
    //        self.detailData = self.modelController.dataStructure[self.dataIndex]

            detailView.delegate = self
            detailView.detailData = self.detailData
            
            self.prepareView()
    //        detailView.detailData = self.detailData
            self.detailView.setLabelTest()
            //detailView.setTabBar() ?

            // hmmmmmmm, feels hacky!
    //        UIApplication.shared.windows.first?.rootViewController = tbController
    //        self.tabBarController = LS_TabBarController(

            self.view = detailView
            self.view.setNeedsDisplay()
        } else {
            self.prepareView()
            self.detailView.setEmptyLabel()
            self.view = detailView
            self.view.setNeedsDisplay()
        }
    }
    
    
    func loadData() {
//        if modelController == nil {
//            print("WARNING: modelController nil")
//            if allData == nil {
//                print("WARNING: allData is also nil")
//
//                // giving allData a dummy value for now, will eventually load from a plist
//                allData?.append(LS_Data(name: "First"))
//            } else {
//                print("allData has \(allData?.count ?? -1) elements")
//
//                modelController.dataStructure = allData! // ERRRR, allData HASN'T BEEN UPDATED
//                self.detailData = modelController.dataStructure[self.dataIndex]
//            }
//        } else {
//            print("Loading model data (DDVC)")
//            allData = modelController.dataStructure
//
//            self.detailData = modelController.dataStructure[dataIndex]
//        }
        
        if self.dataIndex == -1 {
            print("WARNING: dataIndex -1")
        } else {
            print("Loading detail data index: \(dataIndex)")
            
            self.detailData = self.delegate.modelController.dataStructure[self.dataIndex]
            
//            if self.tbController == nil {
//                print("tbController is nil. This isn't good")
//                print("but...\(presentingViewController?.tabBarController.unsafelyUnwrapped)")
//            } else {
//              self.detailData = self.tbController.modelController.dataStructure[self.dataIndex]
//
            print("Loaded detail data: \(self.detailData.id)")
//            }
        }
    }
    
    func updateData(modifiedData: LS_Data) {
        print("this method happily copies data between an edit vc and detail vc. HAPPILY")
        
        self.detailData = modifiedData
        
        print("updated detailData: \(self.detailData.name)")
        print("updated detailData.id: \(self.detailData.id)")
        
        // TODO: put the modified detailData in the modelController
        self.saveData(detailData: self.detailData)
    }
    
    func saveData(detailData: LS_Data) {
        print("detailData.id: \(detailData.id)")
        for i in (0...(self.delegate.modelController!.dataStructure.count - 1)) {
            if self.delegate.modelController.dataStructure[i].id == detailData.id {
                print("dataStructure and detailData ids DO match\n\t\(self.delegate.modelController.dataStructure[i].id) : \(detailData.id)")
                print("updating the dataModel at \(i)")
                print("editData.name: \(detailData.name)")

                self.delegate.modelController.dataStructure[i] = detailData
                print("data name in modelController: \(self.delegate.modelController.dataStructure[i].name)")
                
                // TODO: update tableData and dataSource here via delegate
                self.delegate.updateData(index: i)
                self.delegate.updateDataSource()
                self.delegate.tableView.reloadData()
            } else {
                print("dataStructure and detailData ids don't match\n\t\(self.delegate.modelController.dataStructure[i].id) : \(detailData.id)")
            }
        }
    }
    
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return UIImage(named: "beericon") ?? "Beer Icon"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return UIImage(named: "beericon") ?? "Beer Icon"
    }
    
    
    func prepareView() {
        if (self.detailView != nil) {
            if (self.dataIndex != -1) {
                self.detailData = self.delegate.modelController.dataStructure[self.dataIndex]
//                self.detailView.detailData = detailData

                //hmmmmm
                let width = self.view.frame.width
                let height = self.view.frame.height - 44.0

                _navigationBar.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
                        
                let navItem = UINavigationItem(title: "DetailView")
                let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(handleDoneButtonTapped))
                navItem.rightBarButtonItem = doneButton
                navItem.leftBarButtonItem = _editButtonItem
                
                self._navigationBar.setItems([navItem], animated: false)
                _navigationBar.setItems([navigationItem], animated: false)
                self.view.addSubview(_navigationBar)
                self.view.setNeedsLayout()
                //end hmmmmm
            } else {
                print("WARNING: no dataIndex assigned, unable to assign data to view")
            }
        }
    }
    
    func selectTabBarItemWithIndex(value: Int) {
        self.tbController.selectedIndex = 0
        self.tbController.tabBar(self.tbController.tabBar, didSelect: (self.tbController.tabBar.items!)[value])
        
//        self.tbController.modelController = self.modelController
    }
    
    func onBackButtonTouched(sender: UIButton) {
        print("back button touched")
    }
    
    @objc func handleEditButtonTapped() {
//        print("preparing to edit, allData has a length of \(allData?.count ?? -1)")
//        print("edit current view with id: \(String(describing: allData?[dataIndex].id))")
        
        print("preparing to edit detailData with name: \(detailData.name)")
        print("edit current detailData with id: \(String(describing: detailData.id))")
        
        
        if (self.detailData != nil) {
            destinationEditViewController = LS_EditDetailViewController()
//            destinationEditViewController.delegate = self as! LS_EditDataProtocol
//            destinationEditViewController.modelController = self.modelController
//            destinationEditViewController.dataIndex = self.dataIndex
//            destinationEditViewController.editData = self.detailData!
            destinationEditViewController.necessaryData(index: dataIndex, data: detailData)
            destinationEditViewController.editView = LS_EditDetailView()
            destinationEditViewController.delegate = self
            destinationEditViewController.prepareView()
            print("about to push an EditViewController with \(destinationEditViewController.editData.name)")
            self.present(destinationEditViewController, animated: false)
        } else {
            print("eek! no data to edit")
            let destinationEditViewController = LS_EditDetailViewController()
            self.navigationController?.pushViewController(destinationEditViewController, animated: false)
        }
    }
    
    @objc func handleDoneButtonTapped() {
        print("done!")
        
        let navController = UINavigationController(rootViewController: self)
//        UIApplication.shared.keyWindow?.rootViewController = navigationController
        UIApplication.shared.windows.first?.rootViewController = navigationController
        
        // TODO: CHECK delegate exists!
        let destinationTableViewController = delegate! //LS_DataTableViewController()
//        destinationTableViewController.modelController = tbController.modelController
        
        destinationTableViewController.loadData()
        destinationTableViewController.dataTableView.reloadData()
//        destinationTableViewController.dataTableView.beginUpdates()
//        destinationTableViewController.dataTableView.endUpdates()
        self.navigationController?.pushViewController(destinationTableViewController, animated: false)
//        present(destinationTableViewController, animated: true, completion: nil)
    }
}
