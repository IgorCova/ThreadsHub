//
//  CommunitiesViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa
import AppKit

class CommCardViewController: NSViewController {

    @IBOutlet var titleLabel: NSTextField!
    @IBOutlet var commuyityNameTextField: NSTextField!
    @IBOutlet var linkTextField: NSTextField!
    
    @IBOutlet var adminsPopUpButton: NSPopUpButton!
    @IBOutlet var subjectPopUpButton: NSPopUpButton!
    @IBOutlet var deleteButton: NSButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillSubjectsButton()
        fillAdminsButton()

    }
    
    func fillSubjectsButton() {
        SubjectCommData().wsSubjectComm_ReadDict(MyOwnerHubID) { (dirSubjectComm, successful) in
            self.subjectPopUpButton.removeAllItems()
            for subject in dirSubjectComm {
                self.subjectPopUpButton.menu?.addItemWithTitle(subject.name, action: #selector(self.didSelectItem), keyEquivalent: "")
                
            }
        }
    }
    
    func didSelectItem() {
        //subjectPopUpButton.setTitle((subjectPopUpButton.selectedItem?.title)!)// Может Быть
    }
    
    func fillAdminsButton() {
        AdminCommData().wsAdminComm_ReadDict(MyOwnerHubID) { (dirAdminsComm, successful) in
            self.adminsPopUpButton.removeAllItems()
            for admin in dirAdminsComm {
                self.adminsPopUpButton.addItemWithTitle(admin.firstName + " " + admin.lastName)
            }
        }
    }
    
    func setCard(community: Comm?, title: String, deleteButtonHide: Bool) {
        self.titleLabel.stringValue = title
        self.deleteButton.hidden = deleteButtonHide
        
        if community != nil {
            self.commuyityNameTextField.stringValue = (community?.name)!
            self.adminsPopUpButton.itemWithTitle((community?.subjectName)!)
            self.subjectPopUpButton.itemWithTitle((community?.adminName)!)
            self.linkTextField.stringValue = (community?.link)!
        }
        
    }
    
    @IBAction func save(sender: AnyObject) {
        self.dismissController(self)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissController(self)
    }
    @IBAction func delete(sender: AnyObject) {
        self.dismissController(self)
    }
    
}
