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
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.wantsLayer = true
        self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask  // | NSResizableWindowMask
        self.view.window?.title = "Projects"//NSLocalizedString("CommunitiesTitleName", comment: "")
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
        var cellIdentifier = "commNameCell/adminNameCell"
        
        switch tableColumn! {
        case tableView.tableColumns[0]:
            cellIdentifier = "commNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! CommCellView
//            cell.setCell(dirProjects[row])
            self.tableView.deselectRow(row)
            
            return cell
            
        default:
            cellIdentifier = "adminNameCell"
            let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as! NSTableCellView
//            cell.textField?.stringValue = dirProjects[row].adminName
            self.tableView.deselectRow(row)
            
            return cell
            
        }
        
    }
    
}
