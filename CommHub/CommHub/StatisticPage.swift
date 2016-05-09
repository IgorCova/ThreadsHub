//
//  StatisticPage.swift
//  CommHub
//
//  Created by Andrew Dzhur on 2016-05-09.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class StatisticPage: NSViewController {

    @IBOutlet var blueLine: NSView!
    @IBOutlet var greyLine: NSView!
    
    @IBOutlet var membersView: NSView!
    @IBOutlet var menView: NSView!
    @IBOutlet var womenView: NSView!
    @IBOutlet var postsView: NSView!
    @IBOutlet var adminView: NSView!
    @IBOutlet var statView: NSView!
    
    @IBOutlet var members: NSTextField!
    @IBOutlet var posts: NSTextField!
    @IBOutlet var adminName: NSTextField!
    @IBOutlet var commName: NSTextField!
    
    @IBOutlet var adminImage: NSButton!
    @IBOutlet var commImage: NSImageView!
    
    var info: StatisticRow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let info = info {
            self.members.stringValue = String(info.members)
            self.posts.stringValue = String(info.postCount)
            self.adminName.stringValue = info.adminComm_fullName
            self.adminImage.imageFromUrl("https://graph.facebook.com/\( info.adminComm_linkFB ?? "0")/picture?type=normal")
            self.commImage.imageFromUrl(info.comm_photoLink)
            self.commName.stringValue = info.comm_name
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.wantsLayer = true
        
        self.view.window?.title = ""
        
        self.view.layer?.backgroundColor = NSColor.init(hexString: "FFFFFF").CGColor
        self.membersView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor
        self.menView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor
        self.womenView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor
        self.postsView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor
        self.adminView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor
        self.statView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor

        self.blueLine.layer?.backgroundColor = NSColor.init(hexString: "2F65A4").CGColor
        self.greyLine.layer?.backgroundColor = NSColor.init(hexString: "818181").CGColor

    }
    
}
