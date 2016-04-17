//
//  IncreaseCell.swift
//  CommHub
//
//  Created by Andrew Dzhur on 16/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class IncreaseCell: NSTableCellView {
    
    @IBOutlet var increaseLabel: NSTextField!
    @IBOutlet var decreaseLabel: NSTextField!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    func setCell(increase: Double, decrease: Double) {
        self.increaseLabel.stringValue = String(increase) + "%"
        self.decreaseLabel.stringValue = String(decrease) + "%"
    }
    
}
