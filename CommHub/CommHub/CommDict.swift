//
//  CommunitiesViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class CommDictViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet var tableView: NSTableView!
    var comm = [Comm]()

    override func viewDidLoad() {
        super.viewDidLoad()
        CommData().wsComm_ReadDict(MyOwnerHubID) { (dirComm, successful) in
            if successful {
                self.comm = dirComm
                self.tableView.reloadData()
                
            }
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        // Сюда должен прийти массив с базы...
        return comm.count ?? 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellIdentifier = "commNameCell/subjectNameCell/adminNameCell"
        
        switch tableColumn! {
        case tableView.tableColumns[0]:
            cellIdentifier = "commNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! CommCellView
            cell.setCell(comm[row])
            
            return cell
        case tableView.tableColumns[1]:
            cellIdentifier = "subjectNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
            cell.textField?.stringValue = comm[row].subjectName
            print("---------------------------------------------------" + comm[row].subjectName)
            
            return cell
        default:
            cellIdentifier = "adminNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
            cell.textField?.stringValue = comm[row].adminName
            
            return cell
            
        }
        
    }
    
    @IBAction func addNewCommunity(sender: AnyObject) {
        let subview = CommCardViewController(nibName: "CommCard", bundle: nil)!
        subview.view.frame = NSRect(x: 0, y: 0, width: 297, height: 500)
        subview.setCard(nil, title: "Add a new community", deleteButtonHide: true)
        
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
            let subview = CommCardViewController(nibName: "CommCard", bundle: nil)
            subview?.view.frame = NSRect(x: 0, y: 0, width: 297, height: 500)
            subview?.setCard(comm[index], title: "Edit the community", deleteButtonHide: false)
            
            self.presentViewControllerAsSheet(subview!)
            myTableViewFromNotification.deselectRow(index)
            
        }
    }
}