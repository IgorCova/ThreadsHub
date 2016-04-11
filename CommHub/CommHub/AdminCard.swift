//
//  AdminCardVC.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class AdminCardViewController: NSViewController {
    
    @IBOutlet var titleLabel: NSTextField!
    @IBOutlet var contactView: NSView!
    @IBOutlet var firstNameTextField: NSTextField!
    @IBOutlet var secondNameTextField: NSTextField!
    @IBOutlet var phoneNumberTextField: NSTextField!
    @IBOutlet var linkTextField: NSTextField!
    @IBOutlet var deleteButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.3).CGColor
        contactView.layer?.backgroundColor = NSColor.whiteColor().CGColor
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        //self.view.window!.styleMask = NSClosableWindowMask | NSMiniaturizableWindowMask // | NSResizableWindowMask | NSTitledWindowMask
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    func setCard(adminComm: AdminComm?, title: String, deleteButtonHide: BooleanLiteralType) {
        titleLabel.stringValue = title
        deleteButton.hidden = deleteButtonHide
        
        if let admin = adminComm {
            firstNameTextField.stringValue = admin.firstName
            secondNameTextField.stringValue = admin.lastName
            phoneNumberTextField.stringValue = admin.phone
            linkTextField.stringValue = admin.linkFB!
        }
    }
    
    @IBAction func cancel(sender: NSButton) {
        self.dismissViewController(self)
    }
    
    @IBAction func save(sender: NSButton) {
        self.dismissViewController(self)
    }
    
    @IBAction func delete(sender: AnyObject) {
        self.dismissViewController(self)
    }
}
