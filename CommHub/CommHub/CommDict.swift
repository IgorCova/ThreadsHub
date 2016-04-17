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
    var directoryIsAlphabetical = true

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommDictViewController.refreshData), name:"reloadComm", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadComm", object: nil)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.init(hexString: "245082").CGColor
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.backgroundColor = NSColor.init(hexString: "245082")
        self.view.window?.title = "Сообщества "
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
            self.tableView.deselectRow(row)

            return cell
        case tableView.tableColumns[1]:
            cellIdentifier = "subjectNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
            cell.textField?.stringValue = comm[row].subjectName
            self.tableView.deselectRow(row)

            return cell
        default:
            cellIdentifier = "adminNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
            cell.textField?.stringValue = comm[row].adminName
            self.tableView.deselectRow(row)
            
            return cell
            
        }
        
    }
    
    func refreshData(notification: NSNotification){
        CommData().wsComm_ReadDict { (dirComm, successful) in
            if successful {
                self.comm = dirComm
                self.tableView.reloadData()
            }
        }
    }

    func tableView(tableView: NSTableView, didClickTableColumn tableColumn: NSTableColumn) {
        sorting(tableColumn)
    }
    
    func sorting(tableColumn: NSTableColumn) {
        print("Sorting")
        switch tableColumn {
        case tableView.tableColumns[0]:
            if directoryIsAlphabetical {
                comm.sortInPlace { $0.name > $1.name }
                directoryIsAlphabetical = false
            } else {
                comm.sortInPlace { $0.name < $1.name }
                directoryIsAlphabetical = true
            }
        case tableView.tableColumns[1]:
            if directoryIsAlphabetical {
                comm.sortInPlace { $0.subjectName > $1.subjectName }
                directoryIsAlphabetical = false
            } else {
                comm.sortInPlace { $0.subjectName < $1.subjectName }
                directoryIsAlphabetical = true
            }
        case tableView.tableColumns[2]:
            if directoryIsAlphabetical {
                comm.sortInPlace { $0.adminName > $1.adminName }
                directoryIsAlphabetical = false
            } else {
                comm.sortInPlace { $0.adminName < $1.adminName }
                directoryIsAlphabetical = true
            }
        default:
            break
        }
        tableView.reloadData()

    }
    
    @IBAction func addNewCommunity(sender: AnyObject) {
        let subview = CommCardViewController(nibName: "CommCard", bundle: nil)!
        subview.view.frame = NSRect(x: 0, y: 0, width: 297, height: 522)
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
        
        if myTableViewFromNotification.selectedRow >= 0 {
            let subview = CommCardViewController(nibName: "CommCard", bundle: nil)
            subview?.view.frame = NSRect(x: 0, y: 0, width: 297, height: 522)
            subview?.setCard(comm[index], title: "Edit the community", deleteButtonHide: false)
            
            self.presentViewControllerAsSheet(subview!)
            myTableViewFromNotification.deselectRow(index)
        }
    }
}
