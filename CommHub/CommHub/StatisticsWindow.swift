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
    var isInit = true
    
    var dirStatistic: [StatisticRow] = []
    var directoryIsAlphabetical = true
    var sortingColumn: NSTableColumn?
    var dateTypeR: String = "Daily"
    var selectedCell: StatisticRow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(StatisticsWindow.refreshData), name:"reloadSta", object: nil)
        
        self.refresh()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.view.window?.toolbar?.visible = true
        self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask
    }
    
    func refresh() {
        NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil, userInfo: ["dateType": dateType.day.rawValue])
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return dirStatistic.count ?? 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {

        var cellIdentifier = ""
        
        let column = tableView.tableColumns
        let statistic = dirStatistic[row]
        
        switch tableColumn! {
        case column[0]:
            cellIdentifier = "commCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! CommCell
            cell.setCell(statistic.comm_name, categoryName: statistic.subjectComm_name, comm_photoLink: statistic.comm_photoLink, groupID: statistic.comm_groupID, areaCode: statistic.areaComm_code)
            return cell
            
        case column[1]:
            cellIdentifier = "membersCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
            cell.textField?.stringValue = String(statistic.members.divByBits())
            return cell
            
        case column[2]:
            cellIdentifier = "increaseCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! IncreaseCell
            cell.setCell(statistic.increase, increase: statistic.increaseNew, decrease: statistic.increaseOld)
            return cell

        case column[3]:
            cellIdentifier = "reachCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.reachNew, valuePercent: statistic.reachDifPercent)
            return cell
            
        case column[4]:
            cellIdentifier = "postsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.postCountNew, valuePercent: statistic.postCountDifPercent)
            return cell

        case column[5]:
            cellIdentifier = "likesCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.likesNew, valuePercent: statistic.likesDifPercent)
            return cell
            
        case column[6]:
            cellIdentifier = "resharesCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.resharesNew, valuePercent: statistic.resharesDifPercent)
            
            return cell

        case column[7]:
            cellIdentifier = "commentsCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! MetricCell
            cell.setCell(statistic.commentsNew, valuePercent: statistic.commentsDifPercent)
            return cell
            
        default:
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
            return cell
        }
        
    }
    
    func tableView(tableView: NSTableView, didClickTableColumn tableColumn: NSTableColumn) {
        sortingColumn = tableColumn
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

        case column[1]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.members > $1.members }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.members < $1.members }
                directoryIsAlphabetical = true
            }
            
        case column[2]:
            
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.increase > $1.increase }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.increase < $1.increase }
                directoryIsAlphabetical = true
            }
            
        case column[3]:
            
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.reachNew > $1.reachNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.reachNew < $1.reachNew }
                directoryIsAlphabetical = true
            }
            
        case column[4]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.postCountNew > $1.postCountNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.postCountNew < $1.postCountNew }
                directoryIsAlphabetical = true
            }
            
        case column[5]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.likesNew > $1.likesNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.likesNew < $1.likesNew }
                directoryIsAlphabetical = true
            }
            
        case column[6]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.resharesNew > $1.resharesNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.resharesNew < $1.resharesNew }
                directoryIsAlphabetical = true
            }
            
        case column[7]:
            print("Sorting")
            if directoryIsAlphabetical {
                dirStatistic.sortInPlace { $0.commentsNew > $1.commentsNew }
                directoryIsAlphabetical = false
            } else {
                dirStatistic.sortInPlace { $0.commentsNew < $1.commentsNew }
                directoryIsAlphabetical = true
            }
            
        default:
            break
        }
        
        tableView.reloadData()
    }
    
    func refreshData(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            self.dateTypeR = (userInfo["dateType"]) as! String
        }
        
        if socialNetwork == SocialNetwork.VK {
            StaCommData().wsStaCommVK_Report(dateTypeR) { (dirSta, successful) in
                if successful {
                    self.dirStatistic.removeAll()
                    self.dirStatistic = dirSta
                    
                    if self.isInit == true {
                        self.dirStatistic.sortInPlace { $0.members > $1.members }
                        self.directoryIsAlphabetical = false
                        self.isInit = false
                    } else {
                        if let sortingColumn = self.sortingColumn {
                            self.directoryIsAlphabetical = !self.directoryIsAlphabetical
                            self.sorting(sortingColumn)
                        }
                    }
                    self.tableView.reloadData()
                    
                }
            }
            
        } else if socialNetwork == SocialNetwork.OK {
            StaCommData().wsStaCommOK_Report(dateTypeR) { (dirSta, successful) in
                if successful {
                    self.dirStatistic.removeAll()
                    self.dirStatistic = dirSta
                    
                    if self.isInit == true {
                        self.dirStatistic.sortInPlace { $0.members > $1.members }
                        self.directoryIsAlphabetical = false
                        self.isInit = false
                    } else {
                        if let sortingColumn = self.sortingColumn {
                            self.directoryIsAlphabetical = !self.directoryIsAlphabetical
                            self.sorting(sortingColumn)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let myTableViewFromNotification = notification.object as! NSTableView
        
        let index = myTableViewFromNotification.selectedRow
        if index >= 0 {
            selectedCell = dirStatistic[index]
            
            self.performSegueWithIdentifier("toStatisticPage", sender: nil)
            myTableViewFromNotification.deselectRow(index)
        }
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toStatisticPage" {
            let destinationController = segue.destinationController as! StatisticPage
            //destinationController.infoFromComm = selectedCell
            destinationController.comm_id = selectedCell?.comm_id ?? 0
            
        }
    }

}
