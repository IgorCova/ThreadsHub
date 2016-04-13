//
//  AdminCellView.swift
//  CommHub
//
//  Created by Andrew Dzhur on 01/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class AdminCellView: NSTableCellView {

    @IBOutlet var adminImage: NSImageView!
    @IBOutlet var adminFullName: NSTextField!
    @IBOutlet var phoneNumber: NSTextField!
    var linkFB = ""
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        //self.adminImage.layer?.cornerRadius = self.adminImage.frame.size.width/2
    }
    
    func setCell(admin: AdminComm) {
        let urlImage = "https://graph.facebook.com/\( admin.linkFB ?? "0")/picture?type=normal"
        self.adminImage.imageFromUrl(urlImage)
        self.adminFullName.stringValue = admin.firstName + " " + admin.lastName
        self.phoneNumber.stringValue = admin.phone ?? ""
        self.linkFB = admin.linkFB!
        
    }
    
    @IBAction func followLink(sender: NSButton) {
        let url = NSURL(string: "https://www.facebook.com/" + linkFB)
        NSWorkspace.sharedWorkspace().openURL(url!)
    }
}
