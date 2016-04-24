//
//  EXAMPLE.swift
//  CommHub
//
//  Created by Andrew Dzhur on 10/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.titlebarAppearsTransparent = true
        //self.window?.title = "CommHub"
        setStyleMask()
    }
    
    override func windowWillLoad() {
        super.windowWillLoad()
    }
    
    
    func setStyleMask() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        
        if MyOwnerHubID == 0 {
            let initialViewController = storyboard.instantiateControllerWithIdentifier("containerViewController") as! NSViewController
            self.window?.contentViewController = initialViewController

        } else {
            let initialViewController = storyboard.instantiateControllerWithIdentifier("staWindow") as! NSViewController
            self.window?.contentViewController = initialViewController
        }
        
        self.window?.contentView!.wantsLayer = true
        self.window?.backgroundColor = NSColor.init(hexString: "245082")
    }

    @IBAction func refreshData(sender: AnyObject) {
        print("Refresh")
        NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
    }
}
