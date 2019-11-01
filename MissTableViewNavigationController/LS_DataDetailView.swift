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
//    var detailData: LS_Data?
    var button = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.translatesAutoresizingMaskIntoConstraints = false
        // TODO: setupView()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = self.layoutMarginsGuide
        self.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0.0).isActive = true
        
//        self.layoutMargins = UIEdgeInsets(top: self.layoutMargins.top, left: 0.0, bottom: self.layoutMargins.bottom, right: self.layoutMargins.right)
        
        self.backgroundColor = UIColor.blue
        
        let labelTest: UILabel = UILabel(frame: CGRect(x: self.frame.width/2, y: self.frame.height/2, width: self.frame.size.width, height: 30.0))
        self.addSubview(labelTest)
//        labelTest.center = CGPoint(x: super.frame.size.width/2, y: super.frame.size.height/2)
//        labelTest.widthAnchor.constraint(equalToConstant: labelTest.frame.width)
//        labelTest.heightAnchor.constraint(equalToConstant: labelTest.frame.height)
        labelTest.translatesAutoresizingMaskIntoConstraints = false
        labelTest.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelTest.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelTest.backgroundColor = UIColor.clear
        labelTest.textAlignment = .center
        labelTest.text = "blah blah blah"
        labelTest.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0.0).isActive = true
        labelTest.frame.size.height = 30.0
//        labelTest.heightAnchor.constraint(equalTo: margins.heightAnchor, constant: 30.0).isActive = true
//        labelTest.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        labelTest.textColor = UIColor.yellow
        
//        labelTest.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func onBackButtonTouched(sender: UIButton) {
        // invoke the delegate when the button is touched
        delegate?.onBackButtonTouched(sender: sender)
    }
}
