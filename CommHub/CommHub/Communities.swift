//
//  CommunitiesViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class CommunitiesViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet var tableView: NSTableView!
    var communities = [Community]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        // Сюда должен прийти массив с базы...
        return communities.count ?? 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellIdentifier = "mainCell/subjectNameCell/adminNameCell"
        
        switch tableView {
        case tableView.tableColumns[0]:
            cellIdentifier = "mainCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! CommutityCellView
            cell.setCell(communities[row])
            
            return cell
        case tableView.tableColumns[1]:
            cellIdentifier = "subjectNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
            cell.textField?.stringValue = communities[row].subjectName
            
            return cell
        default:
            cellIdentifier = "adminNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
            cell.textField?.stringValue = communities[row].adminName
            
            return cell
            
        }
        
    }
    
    @IBAction func addNewCommunity(sender: AnyObject) {
        let subview = CommunityCardViewController(nibName: "CommunityCard", bundle: nil)!
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
            let subview = CommunityCardViewController(nibName: "CommunityCard", bundle: nil)
            subview?.view.frame = NSRect(x: 0, y: 0, width: 297, height: 500)
            subview?.setCard(communities[index], title: "Edit the community", deleteButtonHide: false)
            
            self.presentViewControllerAsSheet(subview!)
            myTableViewFromNotification.deselectRow(index)
            
        }
    }
}
