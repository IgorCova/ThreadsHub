//
//  AdminsViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 31/03/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class AdminsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet var tableView: NSTableView!
    var dirAdmins = [AdminComm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.wantsLayer = true
        //self.view.window?.backgroundColor = NSColor(calibratedRed: 67, green: 91, blue: 162, alpha: 0)
        AdminCommData().wsAdminComm_ReadDict(MyOwnerHubID) { (dirAdminsComm, successful) in
            if successful {
                self.dirAdmins = dirAdminsComm
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask // | NSResizableWindowMask
    }
    
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
        return dirAdmins.count ?? 0
    }
        
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellIdentifier = "AdminCell"
        let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! AdminCellView
        cell.setCell(dirAdmins[row])
        return cell
    }
    
    @IBAction func addNewAdmin(sender: AnyObject) {
        let subview = AdminCardViewController(nibName: "AdminCard", bundle: nil)!
        subview.view.frame = NSRect(x: 0, y: 0, width: 297, height: 500)
        subview.setCard(nil, title: "Add the administrator", deleteButtonHide: true)
        
        self.presentViewControllerAsSheet(subview)
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let myTableViewFromNotification = notification.object as! NSTableView
        let index = myTableViewFromNotification.selectedRow
        
        if myTableViewFromNotification.selectedRow > -1 {
            let subview = AdminCardViewController(nibName: "AdminCard", bundle: nil)
            subview?.view.frame = NSRect(x: 0, y: 0, width: 297, height: 500)
            subview?.setCard(dirAdmins[index], title: "Edit the administrator", deleteButtonHide: false)
            
            self.presentViewControllerAsSheet(subview!)
            myTableViewFromNotification.deselectRow(index)

        }
    }

}