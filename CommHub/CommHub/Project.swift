//
//  Project.swift
//  CommHub
//
//  Created by Andrew Dzhur on 10/07/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import Cocoa

class Project: NSObject {
    var id: Int
    var name: String
    var commStatisticRow = [StatisticRow]()
    
    init(id: Int, name: String, commStatisticRow: [StatisticRow]) {
        self.id = id
        self.name = name
        self.commStatisticRow = commStatisticRow
    }
    
    init(name: String, commStatisticRow: [StatisticRow]) {
        self.id = -1
        self.name = name
        self.commStatisticRow = commStatisticRow
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
