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
    @IBOutlet var btnProject: NSButton!
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
    }
    
    @IBAction func showProects(sender: AnyObject) {
        self.btnProject.state = NSOnState

        if reportType != ReportType.Project {
            if let storyBoard = storyboard {
                let projectsViewController = storyBoard.instantiateControllerWithIdentifier("projectsViewController") as! ProjectsViewController
                if let contentViewController = self.contentViewController {
                    contentViewController.presentViewController(projectsViewController, animator: MyCustomSwiftAnimator())
                    reportType = ReportType.Project
                    
                    self.ProjectsButton.image = NSImage(named: "Projects_ON")
                    self.VKButton.image = NSImage(named: "VK_OFF")
                    self.OKButton.image = NSImage(named: "OK_OFF")
                }
                
            }
        }
    }
   
    @IBAction func showStatisticsOK(sender: AnyObject) {
        if reportType != ReportType.OK {
            
            if reportType == ReportType.Project {
                NSNotificationCenter.defaultCenter().postNotificationName("dismisController", object: nil)
            }
            
            reportType = ReportType.OK

            self.ProjectsButton.image = NSImage(named: "Projects_OFF")
            self.VKButton.image = NSImage(named: "VK_OFF")
            self.OKButton.image = NSImage(named: "OK_ON")
            self.btnProject.state = NSOffState
            refreshData(self)
        }
    }

    @IBAction func showStatisticVK(sender: AnyObject) {
        if reportType != ReportType.VK {
            
            if reportType == ReportType.Project {
                NSNotificationCenter.defaultCenter().postNotificationName("dismisController", object: nil)
            }
            
            reportType = ReportType.VK
            
            self.ProjectsButton.image = NSImage(named: "Projects_OFF")
            self.VKButton.image = NSImage(named: "VK_ON")
            self.OKButton.image = NSImage(named: "OK_OFF")
            self.btnProject.state = NSOffState
            
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
        
        if reportType == ReportType.Project {
            NSNotificationCenter.defaultCenter().postNotificationName("refreshProjects", object: nil, userInfo: ["dateType": dt.rawValue])
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil, userInfo: ["dateType": dt.rawValue])
        }

    }
}
