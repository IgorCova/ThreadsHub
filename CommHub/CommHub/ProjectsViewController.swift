//
//  ProjectsViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 10/07/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class ProjectsViewController: NSViewController, NSOutlineViewDelegate, NSOutlineViewDataSource {

    @IBOutlet var outlineView: NSOutlineView!
    
    var projects = [Project]()
    var dateTypeR: String = "Daily"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProjectsViewController.dismisController), name:"dismisController", object: nil)
        refreshData()
    }
    
    func dismisController(notification: NSNotification) {
        self.presentingViewController?.dismissViewController(self)
    }
    
    func refreshData(/*notification: NSNotification*/) {
//        if let userInfo = notification.userInfo {
//            self.dateTypeR = (userInfo["dateType"]) as! String ?? "Day"
//        }
        
            StaCommData().wsStaCommVK_Report("Day") { (dirSta, successful) in
                if successful {
                    self.projects.removeAll()
                    
//                    if self.isInit == true {
//                        self.dirStatistic.sortInPlace { $0.members > $1.members }
//                        self.directoryIsAlphabetical = false
//                        self.isInit = false
//                    } else {
//                        if let sortingColumn = self.sortingColumn {
//                            self.directoryIsAlphabetical = !self.directoryIsAlphabetical
//                            self.sorting(sortingColumn)
//                        }
//                    }
//                    self.tableView.reloadData()
                    
                    var isIn: Bool = false
                    for row in dirSta {
                        if self.projects.isEmpty {
                            self.projects.append(Project(id: row.projectHub_id, name: row.projectHub_name, statisticRows: [row]))
                        } else {
                            isIn = false
                            for project in self.projects {
                                if project.id == row.projectHub_id {
                                    project.statisticRows.append(row)
                                    isIn = true
                                    break
                                }
                                
                            }
                            if isIn == false {
                                self.projects.append(Project(id: row.projectHub_id, name: row.projectHub_name, statisticRows: [row]))
                                
                            }
                            
                        }
                    }
                }
                print("**********************************")
                print(self.projects.count)
                self.outlineView.reloadData()
            }
    }
    
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        //1
        if let project = item as? Project {
            return project.statisticRows.count
        }
        //2
        return projects.count
    }
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if let project = item as? Project {
            return project.statisticRows[index]
        }
        
        return projects[index]
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        if let project = item as? Project {
            return project.statisticRows.count > 0
        }
        
        return false

    }
    
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {

        var view: NSTableCellView?
        
        if let project = item as? Project {
            
            if tableColumn?.identifier == "MainColumn"{
                let cell = self.outlineView.makeViewWithIdentifier("commCell", owner: self) as! CommCell
                cell.commName.stringValue = project.name
                return cell
            }
            
        } else if let statisticRow = item as? StatisticRow {
            
            switch tableColumn!.identifier {
            case "MainColumn":
                let cell = self.outlineView.makeViewWithIdentifier("commCell", owner: self) as! CommCell
                cell.setCell(statisticRow.comm_name, categoryName: statisticRow.subjectComm_name, comm_photoLink: statisticRow.comm_photoLink, groupID: statisticRow.comm_groupID, areaCode: statisticRow.areaComm_code)
                return cell
                
            case "Likes":
                let cell = self.outlineView.makeViewWithIdentifier("likesCell", owner: self) as! MetricCell
                cell.setCell(statisticRow.likesNew, valuePercent: statisticRow.likesDifPercent)
                return cell
                
            case "Increase":
                let cell = self.outlineView.makeViewWithIdentifier("increaseCell", owner: self) as! IncreaseCell
                cell.setCell(statisticRow.increase, increase: statisticRow.increaseNew, decrease: statisticRow.increaseOld)
                return cell
                
            case "Reshares":
                let cell = self.outlineView.makeViewWithIdentifier("resharesCell", owner: self) as! MetricCell
                cell.setCell(statisticRow.resharesNew, valuePercent: statisticRow.reachDifPercent)
                return cell
                
            case "Members":
                let cell = self.outlineView.makeViewWithIdentifier("membersCell", owner: self) as! NSTableCellView
                cell.textField?.stringValue = String(statisticRow.members.divByBits())
                return cell
                
            case "Comments":
                let cell = self.outlineView.makeViewWithIdentifier("commentsCell", owner: self) as! MetricCell
                cell.setCell(statisticRow.commentsNew, valuePercent: statisticRow.commentsDifPercent)
                return cell
                
            case "Posts":
                let cell = self.outlineView.makeViewWithIdentifier("postsCell", owner: self) as! MetricCell
                cell.setCell(statisticRow.postCountNew, valuePercent: statisticRow.postCountDifPercent)
                return cell
                
            default:
                let cell = self.outlineView.makeViewWithIdentifier("reachCell", owner: self) as! MetricCell
                cell.setCell(statisticRow.commentsNew, valuePercent: statisticRow.commentsDifPercent)
                return cell
            }
        }
 
        return view
    }
}