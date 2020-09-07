//
//  LS_EditDetailViewController.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 21/7/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit
import SwiftUI

class LS_EditDetailViewController: UITableViewController, UITextFieldDelegate, LS_BackButtonDelegate {
    let undefinedString: String = "expected string is empty"
    let undefinedUUID: UUID = UUID()
    
    weak var delegate: LS_DataDetailViewController!
    var editView: LS_EditDetailView!
    var editData: LS_Data!
    var allData: [LS_Data]?
    var editedString: String!
    var dataIndex: Int! // TODO: NEEDS A DEFAULT VALUE in case of screw ups
    
    var modelController: LS_DataController!
    
    var textFieldDelegate: UITextFieldDelegate?
    
    var editingCompletionHandler: ((String) -> Int)?
    var textFieldChangedhandler: ((String) -> Void)?
    var onCommitHandler: (() -> Void)?
    
    @State private var textInput = ""
    
    @IBOutlet var edit_name: String?
    @IBOutlet var textField: UITextField! = UITextField()
    
    @IBAction func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if self.textField.hasText {
            print("end editing textField: \(self.textField.text!)")

            // update data (name)
            editedString = self.textField.text!
            editData.name = self.textField.text!
        } else {
            print("no text to end editing of")
        }
    }
    
    @IBAction func textFieldEditingDidChange(_ sender: UITextField) {
        print("delegate changed?: \(delegate!.data_name)")
        print("changed textField: \(self.textField.text!)")
        print("\(sender.text!)")
        
        print("yay?")
    }
    
    // vars must be lazy properties if they need to be initialised before self exists. These closures DO NOT retain the captured self
    fileprivate lazy var _cancelButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleCancelButtonTapped))
    }()
    
    fileprivate lazy var _saveButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.done, target: self, action: #selector(handleSaveButtonTapped))
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touching?")
        print("textField.text: \(self.textField.text ?? "Editing empty text field")")
        self.textField.becomeFirstResponder()
        
    }
    
    // add a navbar
    override func viewWillLayoutSubviews() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 44))
        self.view.addSubview(navigationBar)
        
        let navigationItem = UINavigationItem(title: "EditDetailView")
        navigationItem.leftBarButtonItem = _cancelButtonItem
        navigationItem.rightBarButtonItem = _saveButtonItem
        
        navigationBar.setItems([navigationItem], animated: false)
        
        self.textField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        
        // set editData's id to the local undefined value for future checks
        print("editData.id: \(editData.id)")
        print("(detail)delegate.id: \(delegate.detailData.id)")
//        editData.id = undefinedUUID
        print("NOW editData.id: \(editData.id)")
        
        editView = LS_EditDetailView()
//        editView.delegate = self
//        editData = self.modelController.dataStructure[self.dataIndex] // editData is the data object matching the selected row from the tableview
        editView.editData = editData
        
        textField = UITextField()
        textFieldDelegate = self.textField.delegate
        
        edit_name = editView.editData?.name
        self.textField.delegate = self
//        self.textField.text = self.modelController.dataStructure[self.dataIndex].name //edit_name
        self.textField.text = self.editData.name
        self.textField.returnKeyType = UIReturnKeyType.done
        self.textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: UIControl.Event.editingDidEnd)
        self.textField.addTarget(self, action: #selector(self.textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        self.textField.becomeFirstResponder()
        
        editView.addSubview(textField)
        
        print("just initialised textField with text of \(self.textField.text ?? "self.textField.text is empty")")
        print("assigning that to a variable?")
        let demo: String = self.textField.text!
        print("demo: \(demo)")
        
        self.navigationItem.leftBarButtonItem = _cancelButtonItem
        self.title = "Hmm Edit (\(edit_name ?? "defaultEditName"))"
        self.navigationItem.rightBarButtonItem = _saveButtonItem
        
        editView.setEditTest()
        
        self.view = editView
    }
    
    func loadData() {
//        if modelController == nil {
//            print("WARNING: modelController nil")
//            if allData == nil {
//                print("WARNING: allData is also nil, this should never happen!")
//            } else {
//                print("allData has \(allData?.count ?? -1) elements")
//
//                self.editData = modelController.dataStructure[self.dataIndex]
//                print("editData has name \(editData.name)")
//            }
//        } else {
//            print("Loading model data (EDVC)")
//            allData = modelController.dataStructure
//
//            editData = modelController.dataStructure[dataIndex]
//            editView.editData = editData
//        }
        
        if self.dataIndex == -1 {
            print("WARNING: dataIndex = -1")
        } else {
            print("Loading edit data index: \(dataIndex)")
            
            if self.editData == nil {
                self.editData = self.modelController.dataStructure[self.dataIndex]
                
                print("Loaded edit data: \(editData.id)")
            } else {
                print("edit data already loaded with id: \(editData.id)")
            }
        }
    }
    
    func necessaryData(index: Int, data: LS_Data) {
        self.dataIndex = index
        self.editData = data
    }
    
    func prepareView() {
        if (self.editView != nil) {
            if (self.dataIndex != -1) {
                self.editView.editData = self.editData //modelController.dataStructure[self.dataIndex]
            } else {
                print("WARNING: no dataIndex assigned, unable to assign data to view")
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("should begin")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("did begin")
        self.textField.becomeFirstResponder()
        print("text: \(self.textField.text ?? self.undefinedString)")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.reloadInputViews()
        print("TFSEE: self.textField.text: \(self.textField.text ?? self.undefinedString)")
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(self.textField.text ?? self.undefinedString)")
        
        onCommitHandler?()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textField returning with: \(self.textField.text ?? self.undefinedString)")
        self.textField.resignFirstResponder()
        self.view.endEditing(true)
        print("returning from textField with: \(self.textField.text ?? self.undefinedString)")
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentValue = textField.text as NSString? {
            let finalValue = currentValue.replacingCharacters(in: range, with: string) // This method requires an NSString as the string argument, can typecast to String later
            textFieldChangedhandler?(finalValue as String)
        }
        
        return true
    }
    
    @objc func handleCancelButtonTapped() {
        print("cancel changes/additions (\(self.textField.text ?? self.undefinedString))")
        
        let destinationDetailViewController = LS_DataDetailViewController()
        destinationDetailViewController.loadData()
//        destinationDetailViewController.modelController = self.modelController
        destinationDetailViewController.detailData = self.editData
        destinationDetailViewController.dataIndex = self.dataIndex
        
        self.navigationController?.pushViewController(destinationDetailViewController, animated: false)
        present(destinationDetailViewController, animated: false, completion: nil)
    }
    
    @objc func handleSaveButtonTapped() {
        self.view.setNeedsFocusUpdate()
        self.textField.updateFocusIfNeeded()
        print("still first responder: \(self.textField.text ?? self.undefinedString)")
        print("still editing: \(self.textField.text ?? self.undefinedString)")
        self.textField.endEditing(true)
        self.textField.resignFirstResponder()
        
        print("hmm: \(self.editView.getEditTest())")
        
        let finalString = (self.editView.getEditTest()) // NEED to get the desired value from the view it exists in. ARGH! DINGUS!
        print("finalString: \(finalString)")
        self.textField.text = finalString
        
        print("end editing: \(self.textField.text ?? self.undefinedString)")
        self.view.endEditing(true)
        print("textField: \(self.textField.text ?? self.undefinedString)")
        print("save changes/additions -- for id: \(editData?.id ?? self.undefinedUUID), name: \(editData?.name ?? self.undefinedString)")
        print("***** \(self.textField.text ?? self.undefinedString)")
        
        print("textField is now: \(self.textField.text ?? self.undefinedString)")
        

        self.edit_name = self.textField.text!
        self.editedString = self.textField.text!
        
        if (editData != nil) {
            let destinationDetailViewController = LS_DataDetailViewController()

            // update data before segue to the destination
            editData.name = self.edit_name! // TODO: This value MUST be the updated textField.text value
            print("edit_name: \(edit_name ?? self.undefinedString)")
//            print("delegate name: \(delegate?.data.name)")

//            for i in (0...(self.modelController!.dataStructure.count - 1)) {
//                if self.modelController.dataStructure[i].id == editData.id {
//                    print("updating the dataModel at \(i)")
//                    print("editData.name: \(editData.name)")
//
//                    self.modelController.dataStructure[i] = editData
//                    print("data name in modelController: \(self.modelController.dataStructure[i].name)")
//                }
//            }
            
            // TODO: YUCK
            destinationDetailViewController.delegate = self.delegate.delegate
            destinationDetailViewController.updateData(modifiedData: editData)
            destinationDetailViewController.saveData(detailData: editData)
            destinationDetailViewController.dataIndex = self.dataIndex
            destinationDetailViewController.loadData()
            destinationDetailViewController.detailData = self.editData
            destinationDetailViewController.prepareView()
            
            self.editData = nil
            
            // reload tableview, dismiss this view
//            destinationTableViewController.dataTableView.reloadData()
            
            self.navigationController?.pushViewController(destinationDetailViewController, animated: false)
            present(destinationDetailViewController, animated: true, completion: nil)
        } else {
            print("eek! no data to save")
            let destinationDetailViewController = LS_DataDetailViewController()
//            WOULD ORDINARY COPY/SAVE DATA HERE destinationDetailViewController.detailData = self.editData
            
            self.navigationController?.pushViewController(destinationDetailViewController, animated: false)
            present(destinationDetailViewController, animated: true, completion: nil)
        }
    }
    
    func onBackButtonTouched(sender: UIButton) {
        print("back button touched")
    }
}
