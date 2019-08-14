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

class LS_EditDetailView: UITableView {
//    var delegate: LS_BackButtonDelegate?
//    var button = UIButton()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.backgroundColor = UIColor.blue
//
//        let labelTest: UILabel = UILabel(frame: CGRect(x: 0.0, y: self.frame.height/2, width: self.frame.width, height: 30.0))
//        labelTest.backgroundColor = UIColor.white
//        labelTest.textAlignment = .center
//        labelTest.text = "blah blah blah"
//        labelTest.textColor = UIColor.white
//
//        self.addSubview(labelTest)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func onBackButtonTouched(sender: UIButton) {
//        // invoke the delegate when the button is touched
//        delegate?.onBackButtonTouched(sender: sender)
//    }
    
    @IBOutlet var tableView: UITableView!
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        tableView = UITableView(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented in LS_EditTableView")
    }
    
    weak var cellDelegate: LS_CellDelegate?
    override var delegate: UITableViewDelegate? {
        didSet {
            cellDelegate = delegate as? LS_CellDelegate
        }
    }
    
    
}
