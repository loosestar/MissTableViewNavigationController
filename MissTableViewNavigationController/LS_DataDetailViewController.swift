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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView = LS_DataDetailView()
        
        detailView.delegate = self
    }
    
    func onBackButtonTouched(sender: UIButton) {
        print("back button touched")
    }
}
