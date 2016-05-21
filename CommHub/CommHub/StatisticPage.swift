//
//  StatisticPage.swift
//  CommHub
//
//  Created by Andrew Dzhur on 2016-05-09.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa
import Foundation
import Charts

class StatisticPage: NSViewController {

    @IBOutlet var blueLine: NSView!
    @IBOutlet var greyLine: NSView!
    
    @IBOutlet var membersView: NSView!
    @IBOutlet var menView: NSView!
    @IBOutlet var womenView: NSView!
    @IBOutlet var postsView: NSView!
    @IBOutlet var adminView: NSView!
    @IBOutlet var statView: NSView!
    
    @IBOutlet var members: NSTextField!
    @IBOutlet var posts: NSTextField!
    @IBOutlet var adminName: NSTextField!
    @IBOutlet var commName: NSTextField!
    
    @IBOutlet var adminImage: NSButton!
    @IBOutlet var commImage: NSImageView!
    
    @IBOutlet var lineChartView: LineChartView!
    
    var info: StatisticRow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let info = info {
            self.members.stringValue = String(info.members)
            self.posts.stringValue = String(info.postCount)
            self.adminName.stringValue = info.adminComm_fullName
            self.adminImage.imageFromUrl("https://graph.facebook.com/\( info.adminComm_linkFB ?? "0")/picture?type=normal")
            self.commImage.imageFromUrl(info.comm_photoLinkBig)
            self.commName.stringValue = info.comm_name
        }
        
        // Do any additional setup after loading the view.
        let xs = Array(1...10).map { return Double($0) }
        let ys = [20.0,25.0, 30.0]
        //let ys2 = xs.map { i in return cos(Double(i / 2.0 / 3.141)) }
        
        let yse = ys.enumerate().map { idx, i in return ChartDataEntry(value: i, xIndex: idx) }
        
        let data = LineChartData(xVals: xs)
        let ds = LineChartDataSet(yVals: yse, label: "Blue")
        ds.colors = [NSColor.init(hexString: "85E0F9")]
        
        data.addDataSet(ds)
        
        self.lineChartView.data = data
        
        //self.lineChartView.gridBackgroundColor = NSUIColor.init(hexString: "B4EFFF")
        
        //self.lineChartView.descriptionText = "Linechart Demo"
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.wantsLayer = true
        
        self.view.window?.title = ""
        
        self.view.layer?.backgroundColor = NSColor.init(hexString: "FFFFFF").CGColor
        self.membersView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor
        self.menView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor
        self.womenView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor
        self.postsView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor
        self.adminView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor
        self.statView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor

        self.blueLine.layer?.backgroundColor = NSColor.init(hexString: "2F65A4").CGColor
        self.greyLine.layer?.backgroundColor = NSColor.init(hexString: "818181").CGColor
        
        
        
        //Example
        self.lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)

    }
    
}
