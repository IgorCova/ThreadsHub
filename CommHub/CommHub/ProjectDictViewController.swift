//
//  ProjectDictViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 15/07/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class ProjectDictViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet var tableView: NSTableView!
    
    var dirProjects = [Project]()
    var directoryIsAlphabetical = true
    var selectedCell: Project?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.setDelegate(self)
        self.tableView.setDataSource(self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProjectDictViewController.refreshData), name:"reloadProjects", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadProjects", object: nil)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.wantsLayer = true
        self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask 
        self.view.window?.title = NSLocalizedString("ProjectsTitleName", comment: "")
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return dirProjects.count ?? 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
            let cellIdentifier = "projectCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! CommCellView
            cell.setProjectCell(dirProjects[row])
            self.tableView.deselectRow(row)
            
            return cell
        }
    
    func tableView(tableView: NSTableView, didClickTableColumn tableColumn: NSTableColumn) {
        print("Sorting")
        if directoryIsAlphabetical {
            dirProjects.sortInPlace { $0.name > $1.name }
            self.directoryIsAlphabetical = false
        } else {
            dirProjects.sortInPlace { $0.name < $1.name }
            self.directoryIsAlphabetical = true
        }
        tableView.reloadData()
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let myTableViewFromNotification = notification.object as! NSTableView
        let index = myTableViewFromNotification.selectedRow
        
        if myTableViewFromNotification.selectedRow >= 0 {
            self.selectedCell = dirProjects[index]
            self.performSegueWithIdentifier("EditProject", sender: nil)
            myTableViewFromNotification.deselectRow(index)
        }
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddProject" {
            (segue.destinationController as! ProjectCardViewController).setCard(nil, deleteButtonHide: true)
        }
        if segue.identifier == "EditProject" {
            (segue.destinationController as! ProjectCardViewController).setCard(selectedCell!, deleteButtonHide: false)
        }
    }
    
    func refreshData(notification: NSNotification) {
        ProjectHubData().wsProjectHub_ReadDict({(dirProjects, successful) in
            if successful {
                self.dirProjects = dirProjects
                self.tableView.reloadData()
            }
        })
    }
    
}
