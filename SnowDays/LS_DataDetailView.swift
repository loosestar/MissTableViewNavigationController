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
        
        self.backgroundColor = UIColor.blue
        
        let labelTest: UILabel = UILabel(frame: CGRect(x: self.frame.width/2, y: self.frame.height/2, width: self.frame.size.width, height: 30.0))
        self.addSubview(labelTest)
//        labelTest.center = CGPoint(x: super.frame.size.width/2, y: super.frame.size.height/2)
//        labelTest.widthAnchor.constraint(equalToConstant: labelTest.frame.width)
//        labelTest.heightAnchor.constraint(equalToConstant: labelTest.frame.height)
        labelTest.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelTest.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelTest.backgroundColor = UIColor.white
        labelTest.textAlignment = .center
        labelTest.text = "blah blah blah"
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
