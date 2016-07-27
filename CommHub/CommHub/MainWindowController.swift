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
    @IBOutlet var VKButton: NSToolbarItem!
    @IBOutlet var OKButton: NSToolbarItem!
    @IBOutlet var ProjectsButton: NSToolbarItem!
    var type: ReportType?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.title = "CommHub"
        self.setStyleMask()
        

    }
    
    override func windowWillLoad() {
        super.windowWillLoad()
        
        let appDelegate = NSApp.delegate as! AppDelegate
        appDelegate.mainWindow = self
    }
    
    func setStyleMask() {
        if MyOwnerHubID == 0 {
            let initialViewController = storyboard!.instantiateControllerWithIdentifier("containerViewController") as! NSViewController
            self.window?.contentViewController = initialViewController
        } else {
            let initialViewController = storyboard!.instantiateControllerWithIdentifier("staWindow") as! NSViewController
            self.window?.contentViewController = initialViewController
        }
        
//        self.window?.contentView!.wantsLayer = true
    }
    
    @IBAction func showProects(sender: AnyObject) {
        if reportType != ReportType.Project {
            reportType = ReportType.Project

            self.ProjectsButton.image = NSImage(named: "Projects_ON")
            self.VKButton.image = NSImage(named: "VK_OFF")
            self.OKButton.image = NSImage(named: "OK_OFF")
            
            let projectsViewController = storyboard!.instantiateControllerWithIdentifier("projectsViewController") as! NSViewController
            self.contentViewController!.presentViewController(projectsViewController, animator: MyCustomSwiftAnimator())
        }
        
    }
   
    @IBAction func showStatisticsOK(sender: AnyObject) {
        if reportType != ReportType.OK {
            reportType = ReportType.OK
            
            NSNotificationCenter.defaultCenter().postNotificationName("dismisController", object: nil)

            self.ProjectsButton.image = NSImage(named: "Projects_OFF")
            self.VKButton.image = NSImage(named: "VK_OFF")
            self.OKButton.image = NSImage(named: "OK_ON")
            
            refreshData(self)
        }
    }

    @IBAction func showStatisticVK(sender: AnyObject) {
        if reportType != ReportType.VK {
            reportType = ReportType.VK
            
            NSNotificationCenter.defaultCenter().postNotificationName("dismisController", object: nil)
            
//            FIXME: Нужно ли делать проверку???
            
            self.ProjectsButton.image = NSImage(named: "Projects_OFF")
            self.VKButton.image = NSImage(named: "VK_ON")
            self.OKButton.image = NSImage(named: "OK_OFF")
            
            refreshData(self)
        }
    }
    
    @IBAction func refreshPeriodicaly(sender: AnyObject) {
        refreshData(self)
    }
    
    @IBAction func refreshData(sender: AnyObject) {
        print("Refresh")
        var dt: dateType
        
        switch self.segPeriod.selectedSegment {
            case 0: dt = dateType.day
            case 1: dt = dateType.yesterday
            case 2: dt = dateType.week
            
            default: dt = dateType.day
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil, userInfo: ["dateType": dt.rawValue])
    }
}
