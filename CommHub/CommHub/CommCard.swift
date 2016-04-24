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
    
    @IBOutlet var groupIDtextField: NSTextField!
    
    @IBOutlet var adminsPopUpButton: NSPopUpButton!
    @IBOutlet var subjectPopUpButton: NSPopUpButton!
    @IBOutlet var deleteButton: NSButton!
    var comm: Comm?
    var subjectsItem = [(index: Int, subject: SubjectComm)]()
    var adminsItem = [(index: Int, admin: AdminComm)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func fillSubjectsButton() {
        SubjectCommData().wsSubjectComm_ReadDict {(dirSubjectComm, successful) in
            self.subjectPopUpButton.removeAllItems()
            var i = 0
            for subject in dirSubjectComm {
                self.subjectPopUpButton.addItemWithTitle(subject.name)
                self.subjectsItem.append((index: i, subject: subject))
                i += 1
            }
            
            if self.deleteButton.hidden == false {
                self.subjectPopUpButton.setTitle(self.comm!.subjectName)
            }
        }
    }
    
    func fillAdminsButton() {
        AdminCommData().wsAdminComm_ReadDict { (dirAdminsComm, successful) in
            self.adminsPopUpButton.removeAllItems()
            var i = 0
            print(dirAdminsComm.count)
            for admin in dirAdminsComm {
                print("**********************")
                print(admin.lastName)
                
                self.adminsPopUpButton.addItemWithTitle(admin.lastName + " " + admin.firstName)
                self.adminsItem.append((index: i, admin: admin))
                i += 1
            }
            
            if self.deleteButton.hidden == false {
                self.adminsPopUpButton.setTitle(self.comm!.adminName)
            }
        }
    }
    
    
    func setCard(community: Comm?, title: String, deleteButtonHide: Bool) {
        self.comm = community
        self.titleLabel.stringValue = title
        self.deleteButton.hidden = deleteButtonHide
        
        if deleteButtonHide == false {
            commuyityNameTextField.editable = false
            linkTextField.editable = false
            groupIDtextField.editable = false
            
        }
        
        if let cm = self.comm {
            self.commuyityNameTextField.stringValue = (cm.name)
            self.linkTextField.stringValue = (cm.link)
            self.groupIDtextField.stringValue = "\(cm.groupID)"
        }
        
        fillSubjectsButton()
        fillAdminsButton()
    }
    
    func saveInfo() {
        // Add alert about empty name.
        var subjectItem: SubjectComm?
        var adminItem: AdminComm?
        
        for item in subjectsItem {
            if item.index == subjectPopUpButton.indexOfSelectedItem {
                subjectItem = item.subject
            }
        }
        
        for item in adminsItem {
            if item.index == adminsPopUpButton.indexOfSelectedItem {
                adminItem = item.admin
                print("-------------------------------------")
                print(item.index)
                print(adminsPopUpButton.indexOfSelectedItem)
                print(adminItem!.id)
                
            }
        }
        print("++++++++++++++++++")
        
        
        if comm == nil {
            comm = Comm(
                 id: 0
                ,name: commuyityNameTextField.stringValue
                ,subject: subjectItem!
                ,admin: adminItem!
                ,link: linkTextField.stringValue
                ,groupID: Int(groupIDtextField.stringValue)!
                ,photoLink: "")
        } else {
            //comm!.name = commuyityNameTextField.stringValue
            comm?.adminID = (adminItem?.id)!
            comm?.subjectID = (subjectItem?.id)!
        }
        
    }
    
    @IBAction func save(sender: AnyObject) {
        saveInfo()
        CommData().wsComm_Save(comm!) { (successful) in
            
            if successful {
                NSNotificationCenter.defaultCenter().postNotificationName("reloadComm", object: nil)
                self.dismissViewController(self)
                NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
            }
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissController(self)
    }
    @IBAction func delete(sender: AnyObject) {
        if let comm = comm {
            CommData().wsComm_Del(comm.id, completion: { (successful) in
                if successful {
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadComm", object: nil)
                    self.dismissViewController(self)
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
                }
            })
        }
    }
}
