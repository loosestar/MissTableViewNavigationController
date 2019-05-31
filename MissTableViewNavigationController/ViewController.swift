//
//  ViewController.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 20/5/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var egNavBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        var leftButton: UIBarButtonItem = UIBarButtonItem(title: "left", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//        var rightButton: UINavigationItem = UINavigationItem(title: "right")
        
        print("table title: \(self.egNavBar.items)")
//        egNavBar.items?.append(leftButton)
//        egNavBar.items?.append(rightButton)
        
//        self.navigationItem.leftBarButtonItem = leftButton
    }

//    func setupNavBar(barHeight: CGFloat) {
//        egNavBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: self.view.frame.width, height: barHeight))
//        egNavBar.translatesAutoresizingMaskIntoConstraints = false
//        egNavBar.frame.origin.x = self.view.safeAreaInsets.left
//        egNavBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
//        egNavBar.frame.size.width = self.view.bounds.width - (self.view.safeAreaInsets.right - self.view.safeAreaInsets.left)
//        egNavBar.frame.size.height = barHeight
//    }
}

