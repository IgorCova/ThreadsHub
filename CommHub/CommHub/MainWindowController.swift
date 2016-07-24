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
    @IBOutlet var VKButton: NSButton!
    @IBOutlet var OKButton: NSButton!
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
    
    enum ReportType {
        case vk
        case ok
        case project
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
        if self.type != ReportType.project {
            
            let projectsViewController = storyboard!.instantiateControllerWithIdentifier("A") as! NSViewController
            self.contentViewController!.presentViewController(projectsViewController, animator: MyCustomSwiftAnimator())
            self.type = ReportType.project
        }
        
    }
   
    @IBAction func showStatisticsOK(sender: AnyObject) {
        if self.type != ReportType.ok {
            
            NSNotificationCenter.defaultCenter().postNotificationName("dismisController", object: nil)

            if  socialNetwork != SocialNetwork.OK {
                self.OKButton.image = NSImage(named: "ok-2")
                self.VKButton.image = NSImage(named: "vk-1")
                socialNetwork = SocialNetwork.OK
            
                refreshData(self)
            }
        
            self.type = ReportType.ok
        }
    }

    @IBAction func showStatisticVK(sender: AnyObject) {
        if self.type != ReportType.vk {
            
            NSNotificationCenter.defaultCenter().postNotificationName("dismisController", object: nil)
            
            if  socialNetwork != SocialNetwork.VK {
                self.OKButton.image = NSImage(named: "ok-1")
                self.VKButton.image = NSImage(named: "vk-2")
                socialNetwork = SocialNetwork.VK
            
                refreshData(self)
            }
            self.type = ReportType.vk
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
