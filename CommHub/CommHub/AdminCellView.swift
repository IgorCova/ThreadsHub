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
    var link = ""
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        //self.adminImage.layer?.cornerRadius = self.adminImage.frame.size.width/2
    }
    
    func setCell(admin:Admin) {
        self.adminImage.image = admin.profileImage
        self.adminFullName.stringValue = admin.firstName! + " " + admin.secondName!
        self.phoneNumber.stringValue = admin.phoneNumber ?? ""
        self.link = admin.link
    }
    
    @IBAction func followLink(sender: NSButton) {
        //let url = NSURL(string: link)
        //NSWorkspace.sharedWorkspace().openURL(url!)
    }
}
