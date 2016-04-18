//
//  StatisticsWindow.swift
//  CommHub
//
//  Created by Andrew Dzhur on 10/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class StatisticsWindow: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var day: NSButton!
    @IBOutlet var week: NSButton!
    @IBOutlet var month: NSButton!
    @IBOutlet var deleteLog: NSButton!
    
    var dirStatistic: [StatisticRow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteLog.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(StatisticsWindow.refreshData), name:"reloadSta", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
        
        self.view.window?.title = "CommHub"
        self.view.window?.miniwindowTitle = "CommHubber"
        
    }
    
    func refreshData(notification: NSNotification){
        StaCommData().wsStaCommVKDaily_ReportDay { (dirSta, successful) in
            if successful {
                self.dirStatistic.removeAll()
                self.tableView.reloadData()
                
                self.dirStatistic = dirSta
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func deleteLog(sender: AnyObject) {
        OwnerHubData().deleteLog()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.init(hexString: "245082").CGColor
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.backgroundColor = NSColor.init(hexString: "245082")
        self.view.window?.title = "CommHub"
        
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return dirStatistic.count ?? 0
    }
    
    func tableView(tableView: NSTableView, didAddRowView rowView: NSTableRowView, forRow row: Int) {
        if(row % 2 == 1) {
           rowView.backgroundColor = NSColor.init(hexString: "BDD5F5")
        }
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {

        var cellIdentifier = "cellComm/participantsCell/increaseCell/reachCell/visitorsCell/postsCell/likesCell/sharesCell/commentsCell/adminCell"
        let column = tableView.tableColumns
        let statistic = dirStatistic[row]
        
        switch tableColumn! {
        case column[0]:
            cellIdentifier = "cellComm"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! CommCell
            cell.setCell(statistic.comm_name, categoryName: statistic.subjectComm_name, comm_photoLink: statistic.comm_photoLink, groupID: statistic.comm_groupID)
            
            return cell
            
        case column[1]:
            cellIdentifier = "participantsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
            cell.textField?.stringValue = String(statistic.members.divByBits())
            
            return cell
            
        case column[2]:
            cellIdentifier = "increaseCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! IncreaseCell
            cell.setCell(statistic.subscribedNewPercent, decrease: statistic.unsubscribedNewPercent)
            
            return cell
            
        case column[3]:
            cellIdentifier = "reachCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.reach, valuePercent: statistic.reachNewPercent)
            
            return cell

        case column[4]:
            cellIdentifier = "visitorsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.visitors, valuePercent: statistic.visitorsNewPercent)
            
            return cell
            
        case column[5]:
            cellIdentifier = "postsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.postCount, valuePercent: statistic.postCountNewPercent)
            
            return cell

        case column[6]:
            cellIdentifier = "likesCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.likes, valuePercent: statistic.likesNewPercent)
            
            return cell
            
        case column[7]:
            cellIdentifier = "sharesCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.reposts, valuePercent: statistic.repostsNewPercent)
            
            return cell

        case column[8]:
            cellIdentifier = "commentsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.comments, valuePercent: statistic.commentsNewPercent)
            
            return cell
            
        default:
            cellIdentifier = "adminCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! AdminCell
            cell.setCell(statistic.adminComm_linkFB, adminName: statistic.adminComm_fullName)
            
            return cell
            
        }
        //self.tableView.deselectRow(row)
        
    }
    
    @IBAction func refreshDataButton(sender: AnyObject) {
        print("Refresh")
        NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
    }
    
}
