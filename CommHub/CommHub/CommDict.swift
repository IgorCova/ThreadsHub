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
    
    var dirComm = [Comm]()
    var directoryIsAlphabetical = true
    var selectedCell: Comm?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.setDelegate(self)
        self.tableView.setDataSource(self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommDictViewController.refreshData), name:"reloadComm", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadComm", object: nil)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.wantsLayer = true
        self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask  // | NSResizableWindowMask
        self.view.window?.title = NSLocalizedString("CommunitiesTitleName", comment: "")
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return dirComm.count ?? 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellIdentifier = "commNameCell/subjectNameCell/adminNameCell"
        
        switch tableColumn! {
        case tableView.tableColumns[0]:
            cellIdentifier = "commNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! CommCellView
            cell.setCell(dirComm[row])
            self.tableView.deselectRow(row)

            return cell
        case tableView.tableColumns[1]:
            cellIdentifier = "subjectNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
            cell.textField?.stringValue = dirComm[row].subjectName
            self.tableView.deselectRow(row)

            return cell
        default:
            cellIdentifier = "adminNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
            cell.textField?.stringValue = dirComm[row].adminName
            self.tableView.deselectRow(row)
            
            return cell
            
        }
        
    }
    
    func tableView(tableView: NSTableView, didClickTableColumn tableColumn: NSTableColumn) {
        switch tableColumn {
        case tableView.tableColumns[0]:
            if directoryIsAlphabetical {
                dirComm.sortInPlace { $0.name > $1.name }
                directoryIsAlphabetical = false
            } else {
                dirComm.sortInPlace { $0.name < $1.name }
                directoryIsAlphabetical = true
            }
        case tableView.tableColumns[1]:
            if directoryIsAlphabetical {
                dirComm.sortInPlace { $0.subjectName > $1.subjectName }
                directoryIsAlphabetical = false
            } else {
                dirComm.sortInPlace { $0.subjectName < $1.subjectName }
                directoryIsAlphabetical = true
            }
        case tableView.tableColumns[2]:
            if directoryIsAlphabetical {
                dirComm.sortInPlace { $0.adminName > $1.adminName }
                directoryIsAlphabetical = false
            } else {
                dirComm.sortInPlace { $0.adminName < $1.adminName }
                directoryIsAlphabetical = true
            }
        default:
            break
        }
        tableView.reloadData()
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let myTableViewFromNotification = notification.object as! NSTableView
        let index = myTableViewFromNotification.selectedRow
        
        if myTableViewFromNotification.selectedRow >= 0 {

            selectedCell = dirComm[index]
            
            self.performSegueWithIdentifier("toEditingComm", sender: nil)
            myTableViewFromNotification.deselectRow(index)
        }
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAddingComm" {
            (segue.destinationController as! CommCardViewController).setCard(nil, deleteButtonHide: true)
        }
        if segue.identifier == "toEditingComm" {
            (segue.destinationController as! CommCardViewController).setCard(selectedCell, deleteButtonHide: false)
        }
    }
    
    func refreshData(notification: NSNotification){
        CommData().wsComm_ReadDict { (dirComm, successful) in
            if successful {
                self.dirComm = dirComm
                self.tableView.reloadData()
            }
        }
    }
    

     

}
