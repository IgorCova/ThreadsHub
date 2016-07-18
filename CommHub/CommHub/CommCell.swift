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
    var areaCode = "vk"
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        self.commImage.wantsLayer = true
        self.commImage.layer!.cornerRadius = 2.0
        self.commImage.layer!.masksToBounds = true
    }
    
    func setCell(commName: String, categoryName: String, comm_photoLink: String, groupID: Int, areaCode: String) {
        self.commName.stringValue = commName
        self.commImage.imageFromUrl(comm_photoLink)
        self.categoryName.stringValue = categoryName
        self.groupID = groupID
        self.areaCode = areaCode
    }
    

    @IBAction func siteComm(sender: AnyObject) {
        if areaCode == "vk" {
            let url = NSURL(string: "https://vk.com/club" + "\(groupID)")
            NSWorkspace.sharedWorkspace().openURL(url!)
        } else if areaCode == "ok" {
            let url = NSURL(string: "https://ok.ru/group/" + "\(groupID)")
            NSWorkspace.sharedWorkspace().openURL(url!)
        }
    }
    
    @IBAction func statisticSite(sender: AnyObject) {
        if areaCode == "vk" {
            let url = NSURL(string: "https://vk.com/stats?gid=" + "\(groupID)")
            NSWorkspace.sharedWorkspace().openURL(url!)
        } else if areaCode == "ok" {
            let url = NSURL(string: "https://ok.ru/group/\(groupID)/stat/")
            NSWorkspace.sharedWorkspace().openURL(url!)

        }
    }
    

}
