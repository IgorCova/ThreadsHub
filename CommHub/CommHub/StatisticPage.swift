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
    
    @IBOutlet var members: NSTextField!
    @IBOutlet var posts: NSTextField!
    @IBOutlet var adminName: NSTextField!
    @IBOutlet var commName: NSTextField!
    
    @IBOutlet var adminImage: NSButton!
    @IBOutlet var commImage: NSImageView!
    
    @IBOutlet var lineChartView: LineChartView!
    
    @IBOutlet weak var segActivityPeriod: NSSegmentedControl!
    @IBOutlet weak var segActivityType: NSSegmentedControl!
    var infoFromComm: StatisticRow?
    var infoForGraph = [VkGraph]()
    
    @IBOutlet weak var imgArea: NSImageView!
    @IBAction func changeActivityType(sender: AnyObject) {
        refreshActivity()
    }
    
    func refreshActivity() {
        var actType = activityType.likes
        
        switch self.segActivityType.selectedSegment {
            case 0: actType = activityType.likes
            case 1: actType = activityType.comments
            case 2: actType = activityType.share
            case 3: actType = activityType.removed
            case 4: actType = activityType.members
            case 5: actType = activityType.membersLost
            
            default: actType = activityType.likes
        }
        
        StatisticPageData().wsStaCommVKGraph_Report((infoFromComm?.comm_id)!, completion: { (dirVkGraph, successful) in
            if successful {
                self.infoForGraph = dirVkGraph
                var dates:[String?] = []
                var actvityValues: [Int] = []
                var actvityValuesLast: [Int] = []
                
                for vkGraph in self.infoForGraph {
                    if (vkGraph.isLast) {
                        switch actType {
                            case activityType.likes: actvityValuesLast.append(vkGraph.likes)
                            case activityType.comments: actvityValuesLast.append(vkGraph.comments)
                            case activityType.share: actvityValuesLast.append(vkGraph.share)
                            case activityType.removed: actvityValuesLast.append(vkGraph.removed)
                            case activityType.members: actvityValuesLast.append(vkGraph.members)
                            case activityType.membersLost: actvityValuesLast.append(vkGraph.membersLost)
                        }
                    } else {
                        if vkGraph.isFuture != true {
                            switch actType {
                                case activityType.likes: actvityValues.append(vkGraph.likes)
                                case activityType.comments: actvityValues.append(vkGraph.comments)
                                case activityType.share: actvityValues.append(vkGraph.share)
                                case activityType.removed: actvityValues.append(vkGraph.removed)
                                case activityType.members: actvityValues.append(vkGraph.members)
                                case activityType.membersLost: actvityValues.append(vkGraph.membersLost)
                            }
                        }
                        dates.append(vkGraph.dayString)
                    }
                }
                
                let xs = Array(0..<dates.count).map { return Double($0) }
                let yActvityValues = actvityValues
                let yActvityValuesLast = actvityValuesLast
                    
                let yActvityValuesE = yActvityValues.enumerate().map { idx, i in return ChartDataEntry(value: Double(i), xIndex: idx) }
                let yActvityValuesLastE = yActvityValuesLast.enumerate().map { idx, i in return ChartDataEntry(value: Double(i), xIndex: idx) }
                    
                let data = LineChartData(xVals: xs)
                
                let labelActvityValues = actType.rawValue
                
                
                let dataActvityValues = LineChartDataSet(yVals: yActvityValuesE, label: labelActvityValues)
                dataActvityValues.colors = [NSColor.init(hexString: "85E0F9")]
                dataActvityValues.drawCircleHoleEnabled = false
                dataActvityValues.drawCubicEnabled = true
                dataActvityValues.circleRadius = 6
                dataActvityValues.circleColors = [NSColor.init(hexString: "85E0F9")]
                    
                let dataActvityValuesLast = LineChartDataSet(yVals: yActvityValuesLastE, label: "\(labelActvityValues) last week")
                dataActvityValuesLast.colors = [NSColor.init(hexString: "E88F96")]
                dataActvityValuesLast.drawCircleHoleEnabled = false
                dataActvityValuesLast.drawCubicEnabled = true
                dataActvityValuesLast.circleRadius = 6
                dataActvityValuesLast.circleColors = [NSColor.init(hexString: "E88F96")]
                    
                data.addDataSet(dataActvityValues)
                data.addDataSet(dataActvityValuesLast)
                    
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
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let info = infoFromComm {
            self.members.stringValue = String(info.members.divByBits())
            self.adminName.stringValue = info.adminComm_fullName
            self.adminImage.imageFromUrl("https://graph.facebook.com/\( info.adminComm_linkFB ?? "0")/picture?type=normal")
            self.commImage.imageFromUrl(info.comm_photoLinkBig)
            self.commName.stringValue = info.comm_name
            self.refreshActivity()
            
            if (info.areaComm_code == "vk") {
                self.imgArea.image = NSImage(named: "vk")
            } else if (info.areaComm_code == "ok") {
                self.imgArea.image = NSImage(named: "ok")
            }
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.wantsLayer = true
        
        self.view.window?.title = ""
        
        self.view.layer?.backgroundColor = NSColor.init(hexString: "FFFFFF").CGColor
        self.membersView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor
        self.adminView.layer?.backgroundColor = NSColor.init(hexString: "FAFAFA").CGColor

        self.blueLine.layer?.backgroundColor = NSColor.init(hexString: "2F65A4").CGColor
        self.greyLine.layer?.backgroundColor = NSColor.init(hexString: "818181").CGColor
        
        self.lineChartView.drawGridBackgroundEnabled = false
        self.lineChartView.drawBordersEnabled = false
        self.lineChartView.descriptionText = ""

        //Example
        self.lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)

    }
    
}
