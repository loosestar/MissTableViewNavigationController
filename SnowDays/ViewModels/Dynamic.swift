//
//  Dynamic.swift
//  MissTableViewNavigationController
//
//  Created by Loose Star on 14/8/19.
//  Copyright © 2019 Loose Star. All rights reserved.
//

// Class to handle properties in ViewModels which are expected to change during the View lifecycle

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    init(_ v: T) {
        value = v
    }
}
