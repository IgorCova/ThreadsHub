//
//  StatisticsWindow.swift
//  CommHub
//
//  Created by Andrew Dzhur on 10/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class StatisticsWindow: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func deleteLog(sender: AnyObject) {
        OwnerHubData().deleteLog()
    }
}
