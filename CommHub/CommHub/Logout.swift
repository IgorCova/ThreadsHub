//
//  Logout.swift
//  CommHub
//
//  Created by Igor Cova on 4/24/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class Logout: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        OwnerHubData().deleteLog()
        for win in NSApplication.sharedApplication().windows {
            win.close()
        }
        
        self.performSegueWithIdentifier("logouted", sender: self)
    }
}
