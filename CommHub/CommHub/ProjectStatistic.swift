//
//  ProjectStatistic.swift
//  CommHub
//
//  Created by Andrew Dzhur on 27/07/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation

class ProjectStatistic {
    var project: Project
    var projectStatisticRow: StatisticRow?
    
    init(project: Project, projectStatisticRow: StatisticRow?) {
        self.project = project
        self.projectStatisticRow = projectStatisticRow
    }
}