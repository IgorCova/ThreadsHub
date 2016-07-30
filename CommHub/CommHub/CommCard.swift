//
//  CommunitiesViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa
import AppKit

class CommCardViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet var commuyityNameTextField: NSTextField!
    @IBOutlet var linkTextField: NSTextField!
    @IBOutlet var profileImage: NSImageView!
    
    
    @IBOutlet var adminsPopUpButton: NSPopUpButton!
    @IBOutlet var subjectPopUpButton: NSPopUpButton!
    @IBOutlet var projectPopUpButton: NSPopUpButton!
    
    @IBOutlet var deleteButton: NSButton!
    @IBOutlet var saveButton: NSButton!
    
    var comm: Comm?
    var deleteButtonHide: Bool?
    var subjectsItem = [(index: Int, subject: SubjectComm)]()
    var adminsItem = [(index: Int, admin: AdminComm)]()
    var projectsItem = [(index: Int, project: Project)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        linkTextField.delegate = self
        
        
        self.view.wantsLayer = true
        deleteButton.hidden = deleteButtonHide!
        
        if deleteButtonHide == false {
            commuyityNameTextField.editable = false
            linkTextField.editable = false
        } else {
            commuyityNameTextField.hidden = true
        }
        
        if let comm = self.comm {
            self.commuyityNameTextField.stringValue = (comm.name)
            self.linkTextField.stringValue = "https://vk.com/\(comm.link)"
            profileImage.imageFromUrl(comm.photoLink)
        }
        
        fillSubjectsButton()
        fillAdminsButton()
        fillProjectsButton()
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        if deleteButtonHide == true {
            self.saveButton.frame.origin.x = 125
        }
        
        // profileImage.layer!.cornerRadius = profileImage.frame.size.height/2
        //profileImage.layer!.masksToBounds = true
        
//        let pstyle = NSMutableParagraphStyle()
//        pstyle.alignment = .Center
//        deleteButton.attributedTitle = NSAttributedString(string: NSLocalizedString("lSD-FE-WR5.title", comment: ""), attributes: [ NSForegroundColorAttributeName : NSColor.whiteColor(), NSParagraphStyleAttributeName : pstyle ])
        
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        if (linkTextField.stringValue.rangeOfString("vk.com") != nil) {
            profileImage.image = NSImage(named: "VK_SN")
        } else if (linkTextField.stringValue.rangeOfString("ok.ru") != nil) {
            profileImage.image = NSImage(named: "OK_SN")
        } else {
            profileImage.image = NSImage(named: "SN_Both")

        }
        
        
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
                self.adminsPopUpButton.addItemWithTitle(admin.lastName + " " + admin.firstName)
                self.adminsItem.append((index: i, admin: admin))
                i += 1
            }
            
            if self.deleteButton.hidden == false {
                self.adminsPopUpButton.setTitle(self.comm!.adminName)
            }
        }
    }
    
    func fillProjectsButton() {
        ProjectHubData().wsProjectHub_ReadDict { ( dirProjects, successful) in
            self.adminsPopUpButton.removeAllItems()
            var i = 0
            print(dirProjects.count)
            self.projectPopUpButton.addItemWithTitle("None")
            self.projectsItem.append((index: i, project: Project(id: 0, name: "None")))
            
            for project in dirProjects {
                i += 1
                self.projectPopUpButton.addItemWithTitle(project.name)
                self.projectsItem.append((index: i, project: project))
            }
            
            if self.deleteButton.hidden == false {
                self.projectPopUpButton.setTitle(self.comm!.projectHub_name)
            }
        }
    }
    
    func setCard(community: Comm?, deleteButtonHide: Bool) {
        self.comm = community
        self.deleteButtonHide = deleteButtonHide
    }
    
    @IBAction func save(sender: AnyObject) {
        if linkTextField.stringValue.isEmpty {
            linkTextField.layer!.borderColor = NSColor.redColor().CGColor
            linkTextField.layer!.borderWidth = 1
        } else {
            linkTextField.layer!.borderWidth = 0
            saveInfo()
            
            CommData().wsComm_Save(comm!) { (successful) in
                
                if successful {
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadComm", object: nil)
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
                    NSNotificationCenter.defaultCenter().postNotificationName("refreshProjects", object: nil)

                    self.dismissViewController(self)
                }
            }
        }
    }
    
    func saveInfo() {
        var subjectItem: SubjectComm?
        var adminItem: AdminComm?
        var projectItem: Project?
        
        for item in subjectsItem {
            if item.index == subjectPopUpButton.indexOfSelectedItem {
                subjectItem = item.subject
            }
        }
        
        for item in adminsItem {
            if item.index == adminsPopUpButton.indexOfSelectedItem {
                adminItem = item.admin
            }
        }
        
        for item in projectsItem {
            if item.index == projectPopUpButton.indexOfSelectedItem {
                projectItem = item.project
            }
        }
        
        if comm == nil {
            comm = Comm(
                id: 0
                ,projectHub_id: projectItem!.id
                ,name: ""
                ,projectHub_name: projectItem!.name
                ,subject: subjectItem!
                ,admin: adminItem!
                ,link: linkTextField.stringValue
                ,groupID: 0
                ,photoLink: "")
        } else {
            comm?.adminID = (adminItem?.id)!
            comm?.subjectID = (subjectItem?.id)!
            comm?.projectHub_id = (projectItem?.id)!
            
        }
        
    }
    
    @IBAction func delete(sender: AnyObject) {
        if let comm = comm {
            CommData().wsComm_Del(comm.id, completion: { (successful) in
                if successful {
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadComm", object: nil)
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
                    self.dismissViewController(self)
                    NSNotificationCenter.defaultCenter().postNotificationName("refreshProjects", object: nil)

                }

            })
            
        }
    }
}
