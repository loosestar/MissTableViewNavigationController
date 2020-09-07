//
//  LS_InitialData.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 19/8/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import Foundation

class LS_Utilities: NSObject, LS_Dummy {
    fileprivate var data: [LS_Data] = []
    
    override init() {
        super.init()
        
        // add data
        addDummyData()
        
    }
    
    fileprivate func addDummyData() {
        var dummyData: [LS_Data] = []
        dummyData.append(LS_Data(name: "One"))
        dummyData.append(LS_Data(name: "Two"))
        dummyData.append(LS_Data(name: "Three"))
        
        data.append(contentsOf: dummyData)
    }
    
    // MARK: LS_InitialData Protocol
    
    func allData() -> [LS_Data] {
        return data
    }
    
    func addData(_ newData: LS_Data) {
        for currentData in data {
            if currentData.id == newData.id {
                // already in memory, don't add newData
                return
            }
        }
        
        data.append(newData)
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: LS_TableDataNotifications.TableDataDidChangeNotification)))
    }
    
    func removeData(_ dataToDelete: LS_Data) {
        data.removeAll(where: { $0.id == dataToDelete.id })
    }
    
    func updateData(_ dataToUpdate: LS_Data) {
        if let indexToUpdate = data.firstIndex(where: { $0.id == dataToUpdate.id }) {
            data[indexToUpdate] = dataToUpdate
        } else {
            print("ERROR: index of updated data not found in data array")
        }
    }
    
    
}
