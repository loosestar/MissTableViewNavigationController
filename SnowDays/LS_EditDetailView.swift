//
//  LS_EditDetailView.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 21/7/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit

//protocol LS_BackButtonDelegate {
//    func onBackButtonTouched(sender: UIButton)
//}

class LS_EditDetailView: UIView {
    var delegate: LS_BackButtonDelegate?
    var editData: LS_Data?
    var button = UIButton()
    var modelController: LS_DataController!
    
    var editStringTest: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)

        // TODO: setupView()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = self.layoutMarginsGuide
        self.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0.0).isActive = true
        
//        self.layoutMargins = UIEdgeInsets(top: self.layoutMargins.top, left: 0.0, bottom: self.layoutMargins.bottom, right: self.layoutMargins.right)
        
        self.backgroundColor = UIColor.blue
    }
        
    func setEditTest() {
        editStringTest = UITextField(frame: CGRect(x: self.frame.width/2, y: self.frame.height/2, width: self.frame.size.width, height: 30.0))
//            UILabel(frame: CGRect(x: self.frame.width/2, y: self.frame.height/2, width: self.frame.size.width, height: 30.0))
        let margins = self.layoutMarginsGuide
        self.addSubview(editStringTest)
        editStringTest.translatesAutoresizingMaskIntoConstraints = false
        editStringTest.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        editStringTest.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        editStringTest.backgroundColor = UIColor.clear
        editStringTest.textAlignment = .center
        editStringTest.text = self.editData?.name
        editStringTest.topAnchor.constraint(equalTo: margins.centerYAnchor, constant: -30.0/2.0).isActive = true
        editStringTest.leadingAnchor.constraint(equalTo: margins.centerXAnchor, constant: -150.0/2.0).isActive = true
        editStringTest.frame.size.height = 30.0
        editStringTest.textColor = UIColor.black
        editStringTest.backgroundColor = UIColor.white
    }
    
    func getEditTest() -> String {
        return editStringTest.text!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func onBackButtonTouched(sender: UIButton) {
        // invoke the delegate when the button is touched
        delegate?.onBackButtonTouched(sender: sender)
    }
}
