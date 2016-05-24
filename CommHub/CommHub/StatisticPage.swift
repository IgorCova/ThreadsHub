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
    
    var infoFromComm: StatisticRow?
    var infoForGraph = [VkGraph]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let info = infoFromComm {
            self.members.stringValue = String(info.members)
            self.posts.stringValue = String(info.postCount)
            self.adminName.stringValue = info.adminComm_fullName
            self.adminImage.imageFromUrl("https://graph.facebook.com/\( info.adminComm_linkFB ?? "0")/picture?type=normal")
            self.commImage.imageFromUrl(info.comm_photoLinkBig)
            self.commName.stringValue = info.comm_name
            
        
            StatisticPageData().wsStaCommVKGraph_Report((infoFromComm?.comm_id)!, completion: { (dirVkGraph, successful) in
                if successful {
                    self.infoForGraph = dirVkGraph
                    var dates:[String?] = []
                    var likes: [Int] = []
                    var likesLast: [Int] = []
                    
                    for vkGraph in self.infoForGraph {
                        if (vkGraph.isLast) {
                            likesLast.append(vkGraph.likes)
                        } else {
                            if vkGraph.isFuture != true {
                                likes.append(vkGraph.likes)
                            }
                            dates.append(vkGraph.dayString)
                        }
                    }
                    
                    let xs = Array(0..<dates.count).map { return Double($0) }
                    let yLikes = likes
                    let yLikesLast = likesLast
                    
                    let yLikesE = yLikes.enumerate().map { idx, i in return ChartDataEntry(value: Double(i), xIndex: idx) }
                    let yLikesLastE = yLikesLast.enumerate().map { idx, i in return ChartDataEntry(value: Double(i), xIndex: idx) }
                    
                    let data = LineChartData(xVals: xs)
                    
                    let dataLikes = LineChartDataSet(yVals: yLikesE, label: "Likes")
                    dataLikes.colors = [NSColor.init(hexString: "85E0F9")]
                    dataLikes.drawCircleHoleEnabled = false
                    dataLikes.drawCubicEnabled = true
                    dataLikes.circleRadius = 6
                    dataLikes.circleColors = [NSColor.init(hexString: "85E0F9")]
                    
                    let dataLikesLast = LineChartDataSet(yVals: yLikesLastE, label: "Last week likes")
                    dataLikesLast.colors = [NSColor.init(hexString: "E88F96")]
                    dataLikesLast.drawCircleHoleEnabled = false
                    dataLikesLast.drawCubicEnabled = true
                    dataLikesLast.circleRadius = 6
                    dataLikesLast.circleColors = [NSColor.init(hexString: "E88F96")]
            
                    
                    data.addDataSet(dataLikes)
                    data.addDataSet(dataLikesLast)
                    
                    self.lineChartView.data = data
                    self.lineChartView.leftAxis.enabled = false
                    
                    let xax = ChartXAxis()
                    xax.labelWidth = 400.00
                    xax.values = dates
                    self.lineChartView.xAxis.labelWidth = 450.00
                    self.lineChartView.xAxis.labelPosition = .Bottom
                    self.lineChartView.xAxis.labelHeight = 50.00
                    self.lineChartView.xAxis.values = dates
                    
                    self.lineChartView.scaleXEnabled = false
                    self.lineChartView.scaleYEnabled = false

                    //self.lineChartView.gridBackgroundColor = NSUIColor.init(hexString: "B4EFFF")
                    //self.lineChartView.descriptionText = "Linechart Demo"
                }
            })
        }
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
        
        self.lineChartView.drawGridBackgroundEnabled = false
        self.lineChartView.drawBordersEnabled = false
        self.lineChartView.descriptionText = ""

        
        //Example
        self.lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)

    }
    
}
