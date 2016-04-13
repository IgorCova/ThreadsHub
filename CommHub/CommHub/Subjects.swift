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
    var isLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.setDelegate(self)
        self.tableView.setDataSource(self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SubjectsViewController.refreshData), name:"reloadSubject", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadSubject", object: nil)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.init(hexString: "245082").CGColor
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.backgroundColor = NSColor.init(hexString: "245082")
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask // | NSResizableWindowMask
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
    
    func refreshData(notification: NSNotification){
            SubjectCommData().wsSubjectComm_ReadDict({(dirSubjectComm, successful) in
                if successful {
                    self.isLoaded = false
                    self.dirSubjects = dirSubjectComm
                    self.tableView.reloadData()
                    self.isLoaded = true
                }
            })
    }
    
    @IBAction func addNewSubject(sender: AnyObject) {
        let subview =  SubjectCardViewController(nibName: "SubjectCard", bundle: nil)!
        subview.view.frame = NSRect(x: 0, y: 0, width: 297, height: 500)
        subview.setCard(nil, title: "Add a new subject", deleteButtonHide: true)
        
        self.presentViewControllerAsSheet(subview)
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        if isLoaded {
            let myTableViewFromNotification = notification.object as! NSTableView
            let index = myTableViewFromNotification.selectedRow
        
            if myTableViewFromNotification.selectedRow >= 0 {
                let subview = SubjectCardViewController(nibName: "SubjectCard", bundle: nil)
                subview?.view.frame = NSRect(x: 0, y: 0, width: 297, height: 500)
                subview?.setCard(dirSubjects[index], title: "Edit the subject", deleteButtonHide: false)
            
                self.presentViewControllerAsSheet(subview!)
                myTableViewFromNotification.deselectRow(index)
            }
        }
    }
}
    
    
    
    
        

    
    
    
    
    

