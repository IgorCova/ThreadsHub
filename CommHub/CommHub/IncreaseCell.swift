//
//  IncreaseCell.swift
//  CommHub
//
//  Created by Andrew Dzhur on 16/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class IncreaseCell: NSTableCellView {
    @IBOutlet var lbValue: NSTextField!
    @IBOutlet var lbIncrease: NSTextField!
    @IBOutlet var lbDecrease: NSTextField!
    @IBOutlet var imDynamic: NSImageView!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    func setCell(value: Int, increase: Int, decrease: Int) {
        self.lbIncrease.stringValue = "+ \(increase.divByBits())"
        self.lbDecrease.stringValue = "- \(decrease.divByBits())"
        self.lbValue.stringValue = value.divByBits()
        
        if decrease > increase {
            self.imDynamic.image = NSImage(named: "down")
        } else {
            self.imDynamic.image = NSImage(named: "up")
        }

    }
    
}
