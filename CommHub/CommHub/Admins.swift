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
    var directoryIsAlphabetical = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        
        self.tableView.setDelegate(self)
        self.tableView.setDataSource(self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SubjectsViewController.refreshData), name:"reloadAdmins", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("reloadAdmins", object: nil)
        self.dirAdmins.sortInPlace {$0.lastName < $1.lastName}
        

    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.init(hexString: "245082").CGColor
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.backgroundColor = NSColor.init(hexString: "245082")
        self.view.window?.title = "Администраторы"
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        //self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask // | NSResizableWindowMask
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
    
    
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func addNewAdmin(sender: AnyObject) {
        let subview = AdminCardViewController(nibName: "AdminCard", bundle: nil)!
        print(self.view.window?.frame)
        subview.view.frame = NSRect(x: 0, y: 0, width: 297, height: 522)
        subview.setCard(nil, title: "Add the administrator", deleteButtonHide: true)
        self.presentViewControllerAsSheet(subview)
        
        //self.view.addSubview(subview.view)
        //Сделать по этому подобию
        //self.view.window?.backgroundColor = NSColor.init(hexString: "152A48")

    }
    
    func refreshData(notification: NSNotification){
        AdminCommData().wsAdminComm_ReadDict { (dirAdminsComm, successful) in
            if successful {
                self.dirAdmins = dirAdminsComm
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(tableView: NSTableView, didClickTableColumn tableColumn: NSTableColumn) {
        sorting()
    }
    
    func sorting() {
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
            let subview = AdminCardViewController(nibName: "AdminCard", bundle: nil)
            subview?.view.frame = NSRect(x: 0, y: 0, width: 297, height: 522)
            subview?.setCard(dirAdmins[index], title: "Edit the administrator", deleteButtonHide: false)
                
            self.presentViewControllerAsSheet(subview!)
            myTableViewFromNotification.deselectRow(index)
        }
    }
    
    
    
    
    
    
    
    func colorWithHexString (hex:String) -> NSColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            return NSColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        return NSColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}