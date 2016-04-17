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
        //self.window?.backgroundColor = NSColor.brownColor()//NSColor(calibratedRed: 26, green: 61, blue: 109, alpha: 0)
        
       // let storyboard = NSStoryboard(name: "Main", bundle: nil)
        //var initialViewController = storyboard.instantiateControllerWithIdentifier("mainWindow")
        
        //if MyOwnerHubID == 0 {
            //initialViewController = storyboard.instantiateControllerWithIdentifier("containerViewController") as! NSViewController
        //}
        //self.window?.contentViewController = initialViewController as? NSViewController
        
    }



}
