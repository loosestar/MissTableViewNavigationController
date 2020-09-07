//
//  LS_TableViewModel.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 16/8/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import Foundation

class LS_TableViewModel: NSObject, LS_DataTableViewModel {
    var name: String
    
    var dataArray: [LS_Data]
    
    func addData(data: LS_Data) {
        dataArray.append(data)
    }
    
    func removeData(dataID: UUID) {
        dataArray.removeAll(where: { $0.id == dataID })
    }
    
    let dataController: LS_DataController
    let dataStructure: [LS_Data]
    
    let title: String
    
    func dataCount() -> Int {
        return dataStructure.count
    }
    
    init(withData data: LS_DataController) {
        self.name = "New Table"
        self.dataController = LS_DataController()
        self.dataStructure = data.dataStructure
        self.dataArray = self.dataStructure
        
        self.title = "temp" // SHOULD BE a variable in LS_DataController
        
        super.init()
        subscribeToNotifications()
    }
    
    deinit {
        unsubscribeFromNotifications()
    }
    
    // MARK: PRIVATE: Methods required for Notifications
    
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(tableDataDidChangeNotification(_:)), name: NSNotification.Name(rawValue: LS_TableDataNotifications.TableDataDidChangeNotification), object: dataStructure)
    }
    
    private func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func tableDataDidChangeNotification(_ notification: NSNotification) {
        print("Something changed, now you know")
    }
}
