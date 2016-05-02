//
//  AdminCardVC.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class AdminCardViewController: NSViewController, NSTextFieldDelegate {
    
    @IBOutlet var firstNameTextField: NSTextField!
    @IBOutlet var lastNameTextField: NSTextField!
    @IBOutlet var phoneNumberTextField: NSTextField!
    @IBOutlet var linkTextField: NSTextField!
    @IBOutlet var deleteButton: NSButton!
    @IBOutlet var saveButton: NSButton!
    @IBOutlet var profileImage: NSImageView!
    
    var admin: AdminComm?
    var deleteButtonHide: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        deleteButton.hidden = deleteButtonHide!

        if let admin = self.admin {
            firstNameTextField.stringValue = admin.firstName
            lastNameTextField.stringValue = admin.lastName
            phoneNumberTextField.stringValue = admin.phone
            linkTextField.stringValue = "https://www.facebook.com/\(admin.linkFB!)"
            profileImage.layer!.cornerRadius = profileImage.frame.size.height/2
            profileImage.layer!.masksToBounds = true
            profileImage.imageFromUrl("https://graph.facebook.com/\( admin.linkFB ?? "0")/picture?type=normal")
        }

    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        if deleteButtonHide == true {
            self.saveButton.frame.origin.x = 125
        }
        
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already 
        }
    }
    
    func setCard(adminComm: AdminComm?, deleteButtonHide: Bool) {
        self.admin = adminComm
        self.deleteButtonHide = deleteButtonHide
    }
    
    @IBAction func save(sender: NSButton) {
        if firstNameTextField.stringValue.isEmpty {
            firstNameTextField.layer!.borderColor = NSColor.redColor().CGColor
            firstNameTextField.layer!.borderWidth = 1
        } else {
            firstNameTextField.layer!.borderWidth = 0
        }
        
        if lastNameTextField.stringValue.isEmpty {
            lastNameTextField.layer!.borderColor = NSColor.redColor().CGColor
            lastNameTextField.layer!.borderWidth = 1
        } else {
            lastNameTextField.layer!.borderWidth = 0
        }
        
        if linkTextField.stringValue.isEmpty {
            linkTextField.layer!.borderColor = NSColor.redColor().CGColor
            linkTextField.layer!.borderWidth = 1
        } else {
            linkTextField.layer!.borderWidth = 0
        }
        
        if !firstNameTextField.stringValue.isEmpty && !lastNameTextField.stringValue.isEmpty && !linkTextField.stringValue.isEmpty {
            saveInfo()
            AdminCommData().wsAdminComm_Save(admin!) { (adminOut, successful) in
                if successful {
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadAdmins", object: nil)
                    self.dismissViewController(self)
                }
            }
        }
        
    }
    
    func saveInfo() {
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
