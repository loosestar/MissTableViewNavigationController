//
//  LS_Dummy.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 19/8/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import Foundation

enum InitialDataNotifications {
    static let DummyDataAdded = "DummyDataAdded"
    static let DummyDataRemoved = "DummyDataRmoved"
    static let DummyDataUpdated = "DummyDataUpdated"
}

protocol LS_Dummy {
    func allData() -> [LS_Data]
    func addData(_ data: LS_Data)
    func removeData(_ data: LS_Data)
    func updateData(_ data: LS_Data)
}
