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
    @IBOutlet var deleteLog: NSButton!
    
    var dirStatistic: [StatisticRow] = []
    var directoryIsAlphabetical = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //deleteLog.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(StatisticsWindow.refreshData), name:"reloadSta", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
        
        self.view.window?.title = "CommHub"
        self.view.window?.miniwindowTitle = "CommHubber"
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.init(hexString: "245082").CGColor
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.backgroundColor = NSColor.init(hexString: "245082")
        self.view.window?.title = "CommHub"
        
    }
    
    @IBAction func deleteLog(sender: AnyObject) {
        OwnerHubData().deleteLog()
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

        var cellIdentifier = "cellComm/membersCell/increaseCell/reachCell/visitorsCell/postsCell/likesCell/sharesCell/commentsCell/adminCell"
        let column = tableView.tableColumns
        let statistic = dirStatistic[row]
        
        switch tableColumn! {
        case column[0]:
            cellIdentifier = "cellComm"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! CommCell
            cell.setCell(statistic.comm_name, categoryName: statistic.subjectComm_name, comm_photoLink: statistic.comm_photoLink, groupID: statistic.comm_groupID)
            
            return cell
            
        case column[1]:
            cellIdentifier = "membersCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
            cell.textField?.stringValue = String(statistic.membersNew.divByBits())
            
            return cell
            
        case column[2]:
            cellIdentifier = "increaseCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! IncreaseCell
            cell.setCell(statistic.subscribedDifPercent, decrease: statistic.unsubscribedDifPercent)
            
            return cell
            
        case column[3]:
            cellIdentifier = "reachCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.reach, valuePercent: statistic.reachDifPercent)
            
            return cell

        case column[4]:
            cellIdentifier = "visitorsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.visitors, valuePercent: statistic.visitorsDifPercent)
            
            return cell
            
        case column[5]:
            cellIdentifier = "postsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.postCount, valuePercent: statistic.postCountDifPercent)
            
            return cell

        case column[6]:
            cellIdentifier = "likesCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.likes, valuePercent: statistic.likesDifPercent)
            
            return cell
            
        case column[7]:
            cellIdentifier = "sharesCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.reposts, valuePercent: statistic.repostsDifPercent)
            
            return cell

        case column[8]:
            cellIdentifier = "commentsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.comments, valuePercent: statistic.commentsDifPercent)
            
            return cell
            
        default:
            cellIdentifier = "adminCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! AdminCell
            cell.setCell(statistic.adminComm_linkFB, adminName: statistic.adminComm_fullName)
            
            return cell
            
        }
    }
    
    func tableView(tableView: NSTableView, didClickTableColumn tableColumn: NSTableColumn) {
        sorting(tableColumn)
    }
    
    func sorting(tableColumn: NSTableColumn) {
        let column = tableView.tableColumns
        switch tableColumn {
        case column[0]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.comm_name > $1.comm_name }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.comm_name < $1.comm_name }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
        case column[1]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.membersNew > $1.membersNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.membersNew < $1.membersNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        case column[2]:
            
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.subscribedNew > $1.subscribedNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.subscribedNew < $1.subscribedNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        case column[3]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.reachNew > $1.reachNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.reachNew < $1.reachNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        case column[4]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.visitorsNew > $1.visitorsNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.visitorsNew < $1.visitorsNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        case column[5]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.postCountNew > $1.postCountNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.postCountNew < $1.postCountNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        case column[6]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.likesNew > $1.likesNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.likesNew < $1.likesNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        case column[7]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.repostsNew > $1.repostsNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.repostsNew < $1.repostsNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        case column[8]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.commentsNew > $1.commentsNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.commentsNew < $1.commentsNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        default:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.adminComm_fullName > $1.adminComm_fullName }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.adminComm_fullName < $1.adminComm_fullName }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
        }
    }
    
    func refreshData(notification: NSNotification){
        StaCommData().wsStaCommVKDaily_Report { (dirSta, successful) in
            if successful {
                self.dirStatistic.removeAll()
                self.tableView.reloadData()
                
                self.dirStatistic = dirSta
                self.tableView.reloadData()
            }
        }
    }

    
    
    @IBAction func refreshDataButton(sender: AnyObject) {
        print("Refresh")
        NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
    }
    
}
