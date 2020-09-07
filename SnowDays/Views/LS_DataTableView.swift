//
//  LS_DataTableView.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 14/8/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import UIKit

// Protocol delegating cell touches to the ViewController
protocol LS_CellDelegate: class {
    func onCellTouched(sender: UITableViewCell)
}

class LS_DataTableView: UITableView {
    weak var cellDelegate: LS_CellDelegate?
    override var delegate: UITableViewDelegate? {
        didSet {
            cellDelegate = delegate as? LS_CellDelegate
        }
    }
    
    @IBOutlet weak var tableName: UILabel!
    
    var viewModel: LS_DataTableViewModel? {
        didSet {
            fillUI()
        }
    }
    
    func onCellTouched(sender: UITableViewCell) {
        // invoke delegate on cell touch
        print("cell touched")
    }
    
    fileprivate func fillUI() {
        guard let viewModel = viewModel else {
            // TODO: Should check for or report no viewModel here?
            return
        }
        
        self.tableName.text = viewModel.name
    }
}
