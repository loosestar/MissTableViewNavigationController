//
//  LS_Media.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 9/2/20.
//  Copyright © 2020 Loose Star. All rights reserved.
//

import Foundation

struct LS_Media {
    var id: UUID
    var type: String
    var name: String
    
    init(id: UUID = UUID(), type: String, name: String) {
        self.id = id
        self.type = type
        self.name = name
    }
}

// provide a description of the class for the console, adhering to Apple's recommendation to provide String(describing:) and print(_:)
// with useful information
extension LS_Media: CustomStringConvertible {
    var description: String {
        return "id: \(id)" + "name: \(name)"
    }
}
