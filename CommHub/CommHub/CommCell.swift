//
//  CommCell.swift
//  CommHub
//
//  Created by Andrew Dzhur on 16/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class CommCell: NSTableCellView {

    @IBOutlet var commImage: NSButton!
    @IBOutlet var commName: NSTextField!
    @IBOutlet var categoryName: NSTextField!
    var groupID = 0
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        self.commImage.layer!.cornerRadius = 2.0
        self.commImage.layer!.masksToBounds = true
    }
    
    func setCell(commName: String, categoryName: String, comm_photoLink: String, groupID: Int) {
        self.commName.stringValue = commName
        self.commImage.imageFromUrl(comm_photoLink)
        self.categoryName.stringValue = categoryName
        self.groupID = groupID
    }
    

    @IBAction func siteComm(sender: AnyObject) {
        let url = NSURL(string: "https://vk.com/club" + "\(groupID)")
        NSWorkspace.sharedWorkspace().openURL(url!)
    }
    
    @IBAction func statisticSite(sender: AnyObject) {
        let url = NSURL(string: "https://vk.com/stats?gid=" + "\(groupID)")
        NSWorkspace.sharedWorkspace().openURL(url!)
    }
    

}
