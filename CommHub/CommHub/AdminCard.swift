//
//  AdminCardVC.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class AdminCardViewController: NSViewController, NSTextFieldDelegate {
    
    @IBOutlet var titleLabel: NSTextField!
    @IBOutlet var contactView: NSView!
    @IBOutlet var firstNameTextField: NSTextField!
    @IBOutlet var lastNameTextField: NSTextField!
    @IBOutlet var phoneNumberTextField: NSTextField!
    @IBOutlet var linkTextField: NSTextField!
    @IBOutlet var deleteButton: NSButton!
    var admin: AdminComm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.3).CGColor
        contactView.layer?.backgroundColor = NSColor.whiteColor().CGColor
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()

    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func saveInfo() {
        // Add alert about empty name.
        if admin == nil {
            admin = AdminComm(
                 id: 0, firstName: firstNameTextField.stringValue
                ,lastName: lastNameTextField.stringValue
                ,phone: phoneNumberTextField.stringValue
                ,linkFB: linkTextField.stringValue)
        } else {
            admin?.firstName = firstNameTextField.stringValue
            admin?.lastName = lastNameTextField.stringValue
            admin?.phone = phoneNumberTextField.stringValue
            admin?.linkFB = linkTextField.stringValue
        }
    }
    
    func setCard(adminComm: AdminComm?, title: String, deleteButtonHide: BooleanLiteralType) {
        self.admin = adminComm
        titleLabel.stringValue = title
        deleteButton.hidden = deleteButtonHide
        
        if let admin = adminComm {
            firstNameTextField.stringValue = admin.firstName
            lastNameTextField.stringValue = admin.lastName
            phoneNumberTextField.stringValue = admin.phone
            linkTextField.stringValue = admin.linkFB!
        }
    }
    
    @IBAction func cancel(sender: NSButton) {
        self.dismissViewController(self)
    }
    
    @IBAction func save(sender: NSButton) {
        saveInfo()
        AdminCommData().wsAdminComm_Save(admin!) { (adminOut, successful) in
            if successful {
                NSNotificationCenter.defaultCenter().postNotificationName("reloadAdmins", object: nil)
                self.dismissViewController(self)
            }
        }
    }
    
    @IBAction func delete(sender: AnyObject) {
        if let admin = admin {
            AdminCommData().wsAdminComm_Del(admin.id) { (successful) in
                if successful {
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadAdmins", object: nil)
                    self.dismissViewController(self)
                }
            }
        }
    }
}
