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
    var button = UIButton()
    
    func onBackButtonTouched(sender: UIButton) {
        // invoke the delegate when the button is touched
        delegate?.onBackButtonTouched(sender: sender)
    }
}
