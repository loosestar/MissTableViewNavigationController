//
//  LS_DataController.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 31/7/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import Foundation

enum LS_TableDataNotifications {
    static let TableDataDidChangeNotification = "TableDataDidChangeNotification"
}

class LS_DataController {
    var dataStructure = [LS_Data]()
    
    // Private helper functions
    
    fileprivate func updateData(_ dataID: UUID, withName: String) {
        if let i = dataStructure.firstIndex(where: { $0.id == dataID} ) {
            dataStructure[i].name = withName
        } else {
            print("no data with id \(dataID) to update")
        }
    }
}
