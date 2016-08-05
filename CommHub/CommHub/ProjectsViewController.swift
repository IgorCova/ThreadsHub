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
    var directoryIsAlphabetical = true
    var sortingColumn: NSTableColumn?
    var selectedCell: ProjectStatistic?
    var isInit = true
    
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
                    
                    if self.isInit == true {
                        self.projectsStatistic.sortInPlace({ (first, second) -> Bool in
                            first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                                return first.members > second.members
                            })
                            return first.projectStatisticRow?.members > second.projectStatisticRow?.members
                        })
                        self.directoryIsAlphabetical = false
                        self.isInit = false
                    } else {
                        if let sortingColumn = self.sortingColumn {
                            self.directoryIsAlphabetical = !self.directoryIsAlphabetical
                            self.sorting(sortingColumn)
                        }
                    }

                    
                }
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
            case "commStaColumn":
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
            case "commStaColumn":
                let cell = self.outlineView.makeViewWithIdentifier("commCell", owner: self) as! CommCell
                cell.setCell(commStatisticRow.comm_name, categoryName: commStatisticRow.subjectComm_name, comm_photoLink: commStatisticRow.comm_photoLink, groupID: commStatisticRow.comm_groupID, areaCode: commStatisticRow.areaComm_code)
                cell.statisticImage.hidden = false
                
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
    
    func outlineView(outlineView: NSOutlineView, didClickTableColumn tableColumn: NSTableColumn) {
        sortingColumn = tableColumn
        sorting(tableColumn)
    }
    
    func sorting(tableColumn: NSTableColumn) {
        
        switch tableColumn.identifier {
        case "commStaColumn":
            if directoryIsAlphabetical {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.comm_name > second.comm_name
                    })
                    return first.project.name > second.project.name
                })
                directoryIsAlphabetical = false
            } else {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.comm_name < second.comm_name
                    })
                    return first.project.name < second.project.name
                })
                directoryIsAlphabetical = true
            }

        case "membersStaColumn":
            if directoryIsAlphabetical {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.members > second.members
                    })
                    return first.projectStatisticRow?.members > second.projectStatisticRow?.members
                })
                directoryIsAlphabetical = false
            } else {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.members < second.members
                    })
                    return first.projectStatisticRow?.members < second.projectStatisticRow?.members
                })
                directoryIsAlphabetical = true
            }
            
        case "increaseStaColumn":
            if directoryIsAlphabetical {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.increase > second.increase
                    })
                    return first.projectStatisticRow?.increase > second.projectStatisticRow?.increase
                })
                directoryIsAlphabetical = false
            } else {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.increase < second.increase
                    })
                    return first.projectStatisticRow?.increase < second.projectStatisticRow?.increase
                })
                directoryIsAlphabetical = true
            }
            
        case "reachStaColumn":
            if directoryIsAlphabetical {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.reachNew > second.reachNew
                    })
                    return first.projectStatisticRow?.reachNew > second.projectStatisticRow?.reachNew
                })
                directoryIsAlphabetical = false
            } else {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.reachNew < second.reachNew
                    })
                    return first.projectStatisticRow?.reachNew < second.projectStatisticRow?.reachNew
                })
                directoryIsAlphabetical = true
            }
            
        case "postsStaColumn":
            if directoryIsAlphabetical {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.postCountNew > second.postCountNew
                    })
                    return first.projectStatisticRow?.postCountNew > second.projectStatisticRow?.postCountNew
                })
                directoryIsAlphabetical = false
            } else {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.postCountNew < second.postCountNew
                    })
                    return first.projectStatisticRow?.postCountNew < second.projectStatisticRow?.postCountNew
                })
                directoryIsAlphabetical = true
            }
            
        case "likesStaColumn":
            if directoryIsAlphabetical {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.likesNew > second.likesNew
                    })
                    return first.projectStatisticRow?.likesNew > second.projectStatisticRow?.likesNew
                })
                directoryIsAlphabetical = false
            } else {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.likesNew < second.likesNew
                    })
                    return first.projectStatisticRow?.likesNew < second.projectStatisticRow?.likesNew
                })
                directoryIsAlphabetical = true
            }
            
        case "resharesStaColumn":
            if directoryIsAlphabetical {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.resharesNew > second.resharesNew
                    })
                    return first.projectStatisticRow?.resharesNew > second.projectStatisticRow?.resharesNew
                })
                directoryIsAlphabetical = false
            } else {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.resharesNew < second.resharesNew
                    })
                    return first.projectStatisticRow?.resharesNew < second.projectStatisticRow?.resharesNew
                })
                directoryIsAlphabetical = true
            }
            
        case "commentsStaColumn":
            if directoryIsAlphabetical {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.commentsNew > second.commentsNew
                    })
                    return first.projectStatisticRow?.commentsNew > second.projectStatisticRow?.commentsNew
                })
                directoryIsAlphabetical = false
            } else {
                projectsStatistic.sortInPlace({ (first, second) -> Bool in
                    first.project.commStatisticRow.sortInPlace({ (first, second) -> Bool in
                        return first.commentsNew < second.commentsNew
                    })
                    return first.projectStatisticRow?.commentsNew < second.projectStatisticRow?.commentsNew
                })
                directoryIsAlphabetical = true
            }
            
        default:
            break
        }
        outlineView.reloadData()
    }
    
    func outlineViewSelectionDidChange(notification: NSNotification) {
        let outlineViewNotification = notification.object as! NSTableView
        
        let index = outlineViewNotification.selectedRow
        if index >= 0 {
//            if projectsStatistic[index].project.commStatisticRow.isEmpty {
                selectedCell = projectsStatistic[index]
//            } else {
            
            
            self.performSegueWithIdentifier("toStatisticPage", sender: nil)
            outlineViewNotification.deselectRow(index)
        }
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toStatisticPage" {
            let destinationController = segue.destinationController as! StatisticPage
            //destinationController.infoFromComm = selectedCell
            destinationController.comm_id = selectedCell?.projectStatisticRow!.comm_id ?? 0
            
        }
    }
}