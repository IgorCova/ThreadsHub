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
    
    var projectsStatistic = [ProjectStatistic]()
    var dateTypeR: String = "Daily"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProjectsViewController.dismisController), name:"dismisController", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProjectsViewController.refreshData), name:"refreshProjects", object: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName("refreshProjects", object: nil, userInfo: ["dateType": dateType.day.rawValue])

    }
    
    func dismisController(notification: NSNotification) {
        self.presentingViewController?.dismissViewController(self)
    }
    
    func refreshData(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            self.dateTypeR = (userInfo["dateType"]) as? String ?? "Daily"
        }
    
            StaCommData().wsStaComm_Report(dateTypeR) { (dirSta, successful) in
                if successful {
                    self.projectsStatistic.removeAll()
                    
                    var isIn: Bool = false
                    print(dirSta)
                    for statisticRow in dirSta {
                         if self.projectsStatistic.isEmpty {
                            switch statisticRow.comm_id {
                            case 0:
                                self.projectsStatistic.append(ProjectStatistic(project: Project(id: statisticRow.projectHub_id, name: statisticRow.projectHub_name, commStatisticRow: []), projectStatisticRow: statisticRow))
                                
                            default:
                                self.projectsStatistic.append(ProjectStatistic(project: Project(id: statisticRow.projectHub_id, name: statisticRow.projectHub_name, commStatisticRow: [statisticRow]), projectStatisticRow: nil))
                            }
                            
                        } else {
                            isIn = false
                            for projectStatistic in self.projectsStatistic {
                                if projectStatistic.project.id == statisticRow.projectHub_id {
                                    projectStatistic.project.commStatisticRow.append(statisticRow)
                                    isIn = true
                                    break
                                }
                            }
                            
                            if isIn == false {
                                switch statisticRow.comm_id {
                                case 0:
                                    self.projectsStatistic.append(ProjectStatistic(project: Project(id: statisticRow.projectHub_id, name: statisticRow.projectHub_name, commStatisticRow: []), projectStatisticRow: statisticRow))
                                default:
                                    self.projectsStatistic.append(ProjectStatistic(project: Project(id: statisticRow.projectHub_id, name: statisticRow.projectHub_name, commStatisticRow: [statisticRow]), projectStatisticRow: nil))
                                }
                                
                            }
                        }
                    }
                }
                print("**********************************")
                print(self.projectsStatistic.count)
                self.outlineView.reloadData()
            }
    }
    
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        
        if let projectStatistic = item as? ProjectStatistic {
            return projectStatistic.project.commStatisticRow.count
        }
        
        return projectsStatistic.count
    }
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if let projectStatistic = item as? ProjectStatistic {
            return projectStatistic.project.commStatisticRow[index]
        }
        
        return projectsStatistic[index]
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        if let projectStatistic = item as? ProjectStatistic {
            return projectStatistic.project.commStatisticRow.count > 0
        }
        
        return false

    }
    
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        
        if let projectStatistics = item as? ProjectStatistic {
            let projectSta = projectStatistics.projectStatisticRow!
            
            switch tableColumn!.identifier {
            case "projectsStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("commCell", owner: self) as! CommCell
                cell.setCell(projectSta.projectHub_name, categoryName: projectSta.subjectComm_name, comm_photoLink: projectSta.comm_photoLink, groupID: projectSta.comm_groupID, areaCode: projectSta.areaComm_code)
                cell.statisticImage.hidden = true
                return cell
                
            case "likesStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("likesCell", owner: self) as! MetricCell
                cell.setCell(projectSta.likesNew, valuePercent: projectSta.likesDifPercent)
                return cell
                
            case "increaseStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("increaseCell", owner: self) as! IncreaseCell
                cell.setCell(projectSta.increase, increase: projectSta.increaseNew, decrease: projectSta.increaseOld)
                return cell
                
            case "resharesStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("resharesCell", owner: self) as! MetricCell
                cell.setCell(projectSta.resharesNew, valuePercent: projectSta.reachDifPercent)
                return cell
                
            case "membersStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("membersCell", owner: self) as! NSTableCellView
                cell.textField?.stringValue = String(projectSta.members.divByBits())
                return cell
                
            case "commentsStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("commentsCell", owner: self) as! MetricCell
                cell.setCell(projectSta.commentsNew, valuePercent: projectSta.commentsDifPercent)
                return cell
                
            case "postsStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("postsCell", owner: self) as! MetricCell
                cell.setCell(projectSta.postCountNew, valuePercent: projectSta.postCountDifPercent)
                return cell
                
            case "reachStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("reachCell", owner: self) as! MetricCell
                cell.setCell(projectSta.commentsNew, valuePercent: projectSta.commentsDifPercent)
                return cell
                
            default:
                return NSTableCellView()
            }
            
        } else if let commStatisticRow = item as? StatisticRow {
            
            switch tableColumn!.identifier {
            case "projectsStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("commCell", owner: self) as! CommCell
                cell.setCell(commStatisticRow.comm_name, categoryName: commStatisticRow.subjectComm_name, comm_photoLink: commStatisticRow.comm_photoLink, groupID: commStatisticRow.comm_groupID, areaCode: commStatisticRow.areaComm_code)
                return cell
                
            case "likesStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("likesCell", owner: self) as! MetricCell
                cell.setCell(commStatisticRow.likesNew, valuePercent: commStatisticRow.likesDifPercent)
                return cell
                
            case "increaseStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("increaseCell", owner: self) as! IncreaseCell
                cell.setCell(commStatisticRow.increase, increase: commStatisticRow.increaseNew, decrease: commStatisticRow.increaseOld)
                return cell
                
            case "resharesStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("resharesCell", owner: self) as! MetricCell
                cell.setCell(commStatisticRow.resharesNew, valuePercent: commStatisticRow.reachDifPercent)
                return cell
                
            case "membersStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("membersCell", owner: self) as! NSTableCellView
                cell.textField?.stringValue = String(commStatisticRow.members.divByBits())
                return cell
                
            case "commentsStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("commentsCell", owner: self) as! MetricCell
                cell.setCell(commStatisticRow.commentsNew, valuePercent: commStatisticRow.commentsDifPercent)
                return cell
                
            case "postsStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("postsCell", owner: self) as! MetricCell
                cell.setCell(commStatisticRow.postCountNew, valuePercent: commStatisticRow.postCountDifPercent)
                return cell
                
            case "reachStaColumn":
            let cell = self.outlineView.makeViewWithIdentifier("reachCell", owner: self) as! MetricCell
            cell.setCell(commStatisticRow.commentsNew, valuePercent: commStatisticRow.commentsDifPercent)
            return cell
                
            default:
                return NSTableCellView()
                
            }
        }
 
        return NSTableCellView()
    }
}