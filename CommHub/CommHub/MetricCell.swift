//
//  MetricCell.swift
//  CommHub
//
//  Created by Andrew Dzhur on 16/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class MetricCell: NSTableCellView {

    @IBOutlet var value: NSTextField!
    @IBOutlet var dynamicImage: NSImageView!
    @IBOutlet var valuepercent: NSTextField!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    func setCell(value: Int, valuePercent: Double) {
        self.value.stringValue = "\(value)"
        //---
        if valuePercent < 0 {
            self.dynamicImage.image = NSImage(named: "down")
            self.valuepercent.stringValue = String(valuePercent).removePunctMarks() + "%"
        } else {
            self.dynamicImage.image = NSImage(named: "up")
            self.valuepercent.stringValue = String(valuePercent).removePunctMarks() + "%"
        }

    }
}
