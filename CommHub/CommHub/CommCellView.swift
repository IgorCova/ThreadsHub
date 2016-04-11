//
//  CommutityCellView.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class CommCellView: NSTableCellView {

    //@IBOutlet var communityImageProfile: NSButton!
    @IBOutlet var communityName: NSTextField!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

    }
    
    func setCell(community: Comm) {
        //self.communityImageProfile.image = community.communityProfileImage
        self.communityName.stringValue = community.name
    }
    
}
