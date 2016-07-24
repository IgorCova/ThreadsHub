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
    var statisticRows = [StatisticRow]()
    
    init(id: Int, name: String, statisticRows: [StatisticRow]) {
        self.id = id
        self.name = name
        self.statisticRows = statisticRows
    }
    
    init(name: String, statisticRows: [StatisticRow]) {
        self.id = -1
        self.name = name
        self.statisticRows = statisticRows
    }
}
