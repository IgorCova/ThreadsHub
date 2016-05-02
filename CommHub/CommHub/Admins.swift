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
    
    var dirAdmins: [AdminComm] = []
    var directoryIsAlphabetical = true
    var selectedCell: AdminComm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.setDelegate(self)
        self.tableView.setDataSource(self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SubjectsViewController.refreshData), name:"reloadAdmins", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadAdmins", object: nil)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.wantsLayer = true
        self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask  // | NSResizableWindowMask
        self.view.window?.title = NSLocalizedString("AdministratorsTitleName", comment: "")
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
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
    
    func tableView(tableView: NSTableView, didClickTableColumn tableColumn: NSTableColumn) {
        print("Sorting")
        if directoryIsAlphabetical {
            dirAdmins.sortInPlace { $0.lastName > $1.lastName }
            directoryIsAlphabetical = false
        } else {
            dirAdmins.sortInPlace { $0.lastName < $1.lastName }
            directoryIsAlphabetical = true
        }
        tableView.reloadData()
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let myTableViewFromNotification = notification.object as! NSTableView
        
        let index = myTableViewFromNotification.selectedRow
        if index >= 0 {
            selectedCell = dirAdmins[index]
            
            self.performSegueWithIdentifier("toEditingAdmin", sender: nil)
            myTableViewFromNotification.deselectRow(index)
        }
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAddingAdmin" {
            (segue.destinationController as! AdminCardViewController).setCard(nil, deleteButtonHide: true)
        }
        if segue.identifier == "toEditingAdmin" {
            (segue.destinationController as! AdminCardViewController).setCard(selectedCell, deleteButtonHide: false)
        }
    }
    
    func refreshData(notification: NSNotification){
        AdminCommData().wsAdminComm_ReadDict { (dirAdminsComm, successful) in
            if successful {
                self.dirAdmins = dirAdminsComm
                self.tableView.reloadData()
            }
        }
    }
    
}