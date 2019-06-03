//
//  LSData.swift
//  MissTableViewNavigationController
//  A Simple base data model
//
//  Created by Loose Star on 29/5/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

import Foundation

struct LS_Data {
    var id: Int
    var name: String
}
    
extension LS_Data {
    var description: String {
        return "id: \(id)" +
               "name: \(name)"
    }
}
