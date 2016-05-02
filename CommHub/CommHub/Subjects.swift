//
//  ThemesViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class SubjectsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet var tableView: NSTableView!
    
    var dirSubjects: [SubjectComm] = []
    var directoryIsAlphabetical = true
    var selectedCell: SubjectComm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.setDelegate(self)
        self.tableView.setDataSource(self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SubjectsViewController.refreshData), name:"reloadSubject", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadSubject", object: nil)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.wantsLayer = true
        self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask  // | NSResizableWindowMask
        self.view.window?.title = NSLocalizedString("SubjectsTitleName", comment: "")
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        
        return dirSubjects.count ?? 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
            let cellIdentifier = "SubjectNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: self) as! NSTableCellView
            cell.textField?.stringValue = dirSubjects[row].name
            self.tableView.deselectRow(row)
        
            return cell
    }
    
    func tableView(tableView: NSTableView, didClickTableColumn tableColumn: NSTableColumn) {
        print("Sorting")
        if directoryIsAlphabetical {
            dirSubjects.sortInPlace { $0.name > $1.name }
            self.directoryIsAlphabetical = false
        } else {
            dirSubjects.sortInPlace { $0.name < $1.name }
            self.directoryIsAlphabetical = true
        }
        tableView.reloadData()
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let myTableViewFromNotification = notification.object as! NSTableView
        let index = myTableViewFromNotification.selectedRow
        
        if myTableViewFromNotification.selectedRow >= 0 {
            self.selectedCell = dirSubjects[index]
            self.performSegueWithIdentifier("toEditingSubject", sender: nil)
            myTableViewFromNotification.deselectRow(index)
        }
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAddingSubject" {
            (segue.destinationController as! SubjectCardViewController).setCard(nil, deleteButtonHide: true)
        }
        if segue.identifier == "toEditingSubject" {
            (segue.destinationController as! SubjectCardViewController).setCard(selectedCell!, deleteButtonHide: false)
        }
    }

    func refreshData(notification: NSNotification){
        SubjectCommData().wsSubjectComm_ReadDict({(dirSubjectComm, successful) in
            if successful {
                self.dirSubjects = dirSubjectComm
                self.tableView.reloadData()
            }
        })
    }
}






    
    
    
    
    

