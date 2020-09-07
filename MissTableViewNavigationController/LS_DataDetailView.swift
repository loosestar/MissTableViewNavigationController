//
//  LS_DataDetailView.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 17/7/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit

protocol LS_BackButtonDelegate {
    func onBackButtonTouched(sender: UIButton)
}

class LS_DataDetailView: UIView {
    var delegate: LS_BackButtonDelegate?
    var detailData: LS_Data?
    var button = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // TODO: setupView()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // MUST USE safeAreaLayoutGuide for accurate Auto Layout fun from iOS11.0
//        let margins = self.layoutMarginsGuide
        let guide = self.safeAreaLayoutGuide
//        self.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0.0).isActive = true
        self.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 0.0).isActive = true
//        self.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0.0).isActive = true
        self.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0.0).isActive = true
        
        self.backgroundColor = UIColor.blue
    }
    
    func setLabelTest() {
        let labelTest: UILabel = UILabel(frame: CGRect(x: self.frame.width/2, y: self.frame.height/2, width: self.frame.size.width, height: 30.0))
        let margins = self.layoutMarginsGuide
        let guide = self.safeAreaLayoutGuide
        
        print("detailData?.name: \(detailData?.name)")
        
        self.addSubview(labelTest)
        labelTest.translatesAutoresizingMaskIntoConstraints = false
        labelTest.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelTest.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelTest.backgroundColor = UIColor.clear
        labelTest.textAlignment = .center
        labelTest.text = detailData?.name   //"blah blah blah"
        labelTest.topAnchor.constraint(equalTo: guide.centerYAnchor, constant: -30.0/2.0).isActive = true
        labelTest.leadingAnchor.constraint(equalTo: guide.centerXAnchor, constant: -150.0/2.0).isActive = true
        labelTest.frame.size.height = 30.0
        labelTest.textColor = UIColor.yellow
    }
    
    
    func setEmptyLabel() {
        let labelTest: UILabel = UILabel(frame: CGRect(x: self.frame.width/2, y: self.frame.height/2, width: self.frame.size.width, height: 30.0))
        let margins = self.layoutMarginsGuide
        let guide = self.safeAreaLayoutGuide
        
        print("detailData?.name: \"\"")
        
        self.addSubview(labelTest)
        labelTest.translatesAutoresizingMaskIntoConstraints = false
        labelTest.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelTest.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelTest.backgroundColor = UIColor.clear
        labelTest.textAlignment = .center
        labelTest.text = "UNDEFINED"  //"blah blah blah"
        labelTest.topAnchor.constraint(equalTo: guide.centerYAnchor, constant: -30.0/2.0).isActive = true
        labelTest.leadingAnchor.constraint(equalTo: guide.centerXAnchor, constant: -150.0/2.0).isActive = true
        labelTest.frame.size.height = 30.0
        labelTest.textColor = UIColor.yellow
    }
    
//    func setTabTest() {
//        
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func onBackButtonTouched(sender: UIButton) {
        // invoke the delegate when the button is touched
        delegate?.onBackButtonTouched(sender: sender)
    }
}
