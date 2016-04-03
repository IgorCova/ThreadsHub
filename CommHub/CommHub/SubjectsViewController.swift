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
    var subjects: [Subject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subjects = SubjectData().getSubjects()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask // | NSResizableWindowMask
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        // Сюда должен прийти массив с базы...
        
        return subjects.count ?? 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
            let cellIdentifier = "SubjectNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: self) as! NSTableCellView
            cell.textField?.stringValue = subjects[row].subjectName
            
            return cell
    }
    
    @IBAction func addNewSubject(sender: AnyObject) {
        let subview =  SubjectCardVC(nibName: "SubjectCardVC", bundle: nil)!
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
        let myTableViewFromNotification = notification.object as! NSTableView
        let index = myTableViewFromNotification.selectedRow
        
        if myTableViewFromNotification.selectedRow > -1 {
            let subview = SubjectCardVC(nibName: "SubjectCardVC", bundle: nil)
            subview?.view.frame = NSRect(x: 0, y: 0, width: 297, height: 500)
            subview?.setCard(subjects[index], title: "Edit the subject", deleteButtonHide: false)
            
            self.presentViewControllerAsSheet(subview!)
            myTableViewFromNotification.deselectRow(index)
        
        }
    }
    
}
    
    
    
    
        

    
    
    
    
    

