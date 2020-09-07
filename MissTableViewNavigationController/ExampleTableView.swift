//
//  ExampleTableView.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 17/7/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit

// Protocol delegating cell touches to the ViewController
//protocol LS_CellDelegate: class {
//    func onCellTouched(sender: UITableViewCell)
//}

class ExampleTableView: UITableView {
    weak var cellDelegate: LS_CellDelegate?
    override var delegate: UITableViewDelegate? {
        didSet {
            cellDelegate = delegate as? LS_CellDelegate
        }
    }
    
    func onCellTouched(sender: UITableViewCell) {
        // invoke the delegate when the cell is touched
        print("cell touched")
//        self.cellDelegate?.onCellTouched(sender:)
    }
}
