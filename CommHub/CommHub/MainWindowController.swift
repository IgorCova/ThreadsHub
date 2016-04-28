//
//  EXAMPLE.swift
//  CommHub
//
//  Created by Andrew Dzhur on 10/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet weak var segPeriod: NSSegmentedControl!
    @IBOutlet weak var isPast: NSToolbarItem!
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.titlebarAppearsTransparent = true
        self.window?.title = "CommHub"
        self.setStyleMask()
    }
    
    override func windowWillLoad() {
        super.windowWillLoad()
        
        let appDelegate = NSApp.delegate as! AppDelegate
        appDelegate.mainWindow = self
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
    }

    @IBAction func refreshPeriodicaly(sender: AnyObject) {
        refreshData(self)
    }
    
    @IBAction func refreshData(sender: AnyObject) {
        print("Refresh")
        let isPast: Bool = (self.segPeriod.selectedSegment == 0 ? false : true)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil, userInfo: ["isPast": isPast])
    }
}
