//
//  LS_DataTableViewModel.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 14/8/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import Foundation

protocol LS_DataTableViewModel {
    var name: String { get }
    var dataArray: [LS_Data] { get }
    
    func dataCount() -> Int
    func addData(data: LS_Data)
    func removeData(dataID: UUID)
}
