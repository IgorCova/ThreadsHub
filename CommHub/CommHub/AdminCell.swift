//
//  AdminCell.swift
//  CommHub
//
//  Created by Andrew Dzhur on 16/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class AdminCell: NSTableCellView {

    @IBOutlet var imageProfile: NSButton!
    @IBOutlet var adminName: NSTextField!
    var linkFB = ""
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        self.imageProfile.layer!.cornerRadius = self.imageProfile.frame.size.height/2
        self.imageProfile.layer!.masksToBounds = true
    }
    
    func setCell(linkFB: String, adminName: String) {
        let urlImage = "https://graph.facebook.com/\(linkFB)/picture?type=normal"
        self.imageProfile.imageFromUrl(urlImage)

        self.adminName.stringValue = adminName
        self.linkFB = linkFB
        
    }
    @IBAction func toFB(sender: AnyObject) {
        let url = NSURL(string: "https://www.facebook.com/" + "\(linkFB)")
        NSWorkspace.sharedWorkspace().openURL(url!)
    }
}
