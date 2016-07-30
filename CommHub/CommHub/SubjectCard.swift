//
//  ThemesCardVC.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class SubjectCardViewController: NSViewController {

    @IBOutlet var subjectNameTextField: NSTextField!
    @IBOutlet var deleteButton: NSButton!
    @IBOutlet var saveButton: NSButton!
    
    var subject: SubjectComm?
    var deleteButtonHide: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        deleteButton.hidden = deleteButtonHide!
        
        if let subject = self.subject {
            subjectNameTextField.stringValue = subject.name
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        if deleteButtonHide == true {
            self.saveButton.frame.origin.x = 125
        }
        
//        let pstyle = NSMutableParagraphStyle()
//        pstyle.alignment = .Center
//        deleteButton.attributedTitle = NSAttributedString(string: NSLocalizedString("NHV-l3-fbk.title", comment: ""), attributes: [ NSForegroundColorAttributeName : NSColor.whiteColor(), NSParagraphStyleAttributeName : pstyle ])
        
    }
    
    func setCard(subject: SubjectComm?, deleteButtonHide: Bool) {
        self.subject = subject
        self.deleteButtonHide = deleteButtonHide
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        if subjectNameTextField.stringValue.isEmpty {
            subjectNameTextField.layer!.borderColor = NSColor.redColor().CGColor
            subjectNameTextField.layer!.borderWidth = 1
        } else {
            subjectNameTextField.layer!.borderWidth = 0
            saveInfo()
            SubjectCommData().wsSubjectComm_Save(subject!) { (subjectOut, successful) in
//                self.saveInfo()
                
                if successful {
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadSubject", object: nil)
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
                    self.dismissViewController(self)
                }
            }
        }
    }
    
    func saveInfo() {
        // Add alert about empty name.
        if subject == nil {
            subject = SubjectComm(
                id: 0
                ,name: subjectNameTextField.stringValue)
        } else {
            subject?.name = subjectNameTextField.stringValue
        }
    }
    
    @IBAction func deleteButton(sender: AnyObject) {
        if let subject = subject {
            SubjectCommData().wsSubjectComm_Del(subject.id) { (successful) in
                if successful {
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadSubject", object: nil)
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
                    self.dismissViewController(self)
                }
            }
        }
    }
}
