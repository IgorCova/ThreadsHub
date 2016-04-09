//
//  CommunitiesViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa
import AppKit

class CommunityCardViewController: NSViewController {

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
        let subjects = SubjectData().getSubjects()
        subjectPopUpButton.removeAllItems()
        for subject in subjects {
            subjectPopUpButton.menu?.addItemWithTitle(subject.subjectName, action: #selector(self.didSelectItem), keyEquivalent: "")
            
        }
    }
    
    func didSelectItem() {
        //subjectPopUpButton.setTitle((subjectPopUpButton.selectedItem?.title)!)// Может Быть
    }
    
    func fillAdminsButton() {
        let admins = AdminData().getAdmins()
        adminsPopUpButton.removeAllItems()
        for admin in admins {
            adminsPopUpButton.addItemWithTitle(admin.firstName! + " " + admin.secondName!)
        }
        
    }
    
    func setCard(community: Community?, title: String, deleteButtonHide: Bool) {
        self.titleLabel.stringValue = title
        self.deleteButton.hidden = deleteButtonHide
        
        if community != nil {
            self.commuyityNameTextField.stringValue = (community?.communityName)!
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
