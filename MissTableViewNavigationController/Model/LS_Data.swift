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

// provide a description of the class for the console, adhering to Apple's recommendation to provide String(describing:) and print(_:)
// with useful information
extension LS_Data: CustomStringConvertible {
    var description: String {
        return "id: \(id)" + "name: \(name)"
    }
}
