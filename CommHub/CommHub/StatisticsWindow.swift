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
    
    var dirStatistic: [StatisticRow] = []
    var directoryIsAlphabetical = true
    var isPast = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refresh()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.refresh()
        
        self.view.window?.toolbar?.visible = true
        self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask
    }
    
    func refresh() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(StatisticsWindow.refreshData), name:"reloadSta", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil, userInfo: ["isPast": false])

    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return dirStatistic.count ?? 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {

        var cellIdentifier = "cellComm/membersCell/increaseCell/reachCell/visitorsCell/viewsCell/postsCell/likesCell/sharesCell/commentsCell/adminCell"
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
            cell.textField?.stringValue = String(statistic.members.divByBits())
            
            return cell
            
        case column[2]:
            cellIdentifier = "increaseCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.increaseNew, valuePercent: statistic.increaseDifPercent)
            
            return cell
            
        case column[3]:
            cellIdentifier = "reachCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.reachNew, valuePercent: statistic.reachDifPercent)
            
            return cell

        case column[4]:
            cellIdentifier = "visitorsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.visitorsNew, valuePercent: statistic.visitorsDifPercent)
            
            return cell
        
        case column[5]:
            cellIdentifier = "viewsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.viewsNew, valuePercent: statistic.viewsDifPercent)
            
            return cell
            
        case column[6]:
            cellIdentifier = "postsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.postCountNew, valuePercent: statistic.postCountDifPercent)
            
            return cell

        case column[7]:
            cellIdentifier = "likesCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.likesNew, valuePercent: statistic.likesDifPercent)
            
            return cell
            
        case column[8]:
            cellIdentifier = "sharesCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.repostsNew, valuePercent: statistic.repostsDifPercent)
            
            return cell

        case column[9]:
            cellIdentifier = "commentsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.commentsNew, valuePercent: statistic.commentsDifPercent)
            
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
                dirStatistic.sortInPlace { $0.members > $1.members }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.members < $1.members }
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
                dirStatistic.sortInPlace { $0.viewsNew > $1.viewsNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.viewsNew < $1.viewsNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        case column[6]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.postCountNew > $1.postCountNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.postCountNew < $1.postCountNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        case column[7]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.likesNew > $1.likesNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.likesNew < $1.likesNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        case column[8]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.repostsNew > $1.repostsNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.repostsNew < $1.repostsNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        case column[9]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.commentsNew > $1.commentsNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.commentsNew < $1.commentsNew }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        case column[10]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.adminComm_fullName > $1.adminComm_fullName }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.adminComm_fullName < $1.adminComm_fullName }
                directoryIsAlphabetical = true
            }
            tableView.reloadData()
            
        default:
            break
        }
    }
    
    func refreshData(notification: NSNotification){
        if let us = notification.userInfo {
            self.isPast = (us["isPast"] ?? false) as! Bool
        }
        StaCommData().wsStaCommVKDaily_Report(isPast) { (dirSta, successful) in
            if successful {
                self.dirStatistic.removeAll()
                self.tableView.reloadData()
                
                self.dirStatistic = dirSta
                self.tableView.reloadData()
            }
        }
    }

}
