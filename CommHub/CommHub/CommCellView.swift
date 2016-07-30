//
//  CommutityCellView.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class CommCellView: NSTableCellView {

    @IBOutlet var communityName: NSTextField!
    @IBOutlet var imageProfile: NSButton!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

    }
    
    func setCell(community: Comm) {
        self.communityName.stringValue = community.name
        if community.photoLink != "" {
            self.imageProfile.imageFromUrl(community.photoLink)
        } else {
            self.imageProfile.image = NSImage(named: "vk")
        }
    }
    
    func setProjectCell(project: Project) {
        self.communityName.stringValue = project.name
    }
    
}
