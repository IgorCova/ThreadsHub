//
//  ThemesCardVC.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class SubjectCardViewController: NSViewController {

    @IBOutlet var titleLabel: NSTextField!
    @IBOutlet var customView: NSView!
    @IBOutlet var subjectNameTextField: NSTextField!
    @IBOutlet var delete: NSButton!
    var subject: SubjectComm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.3).CGColor
        customView.layer?.backgroundColor = NSColor.whiteColor().CGColor
    }
    
    func setCard(subject: SubjectComm?, title: String, deleteButtonHide: Bool) {
        self.subject = subject
        self.titleLabel.stringValue = title
        self.delete.hidden = deleteButtonHide
        if subject != nil {
            self.subjectNameTextField.stringValue = subject!.name
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
    
    @IBAction func saveButton(sender: AnyObject) {
        saveInfo()
        SubjectCommData().wsSubjectComm_Save(subject!) { (subjectOut, successful) in
            self.saveInfo()

            if successful {
                NSNotificationCenter.defaultCenter().postNotificationName("reloadSubject", object: nil)
                self.dismissViewController(self)
            }
        }
    }

    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissController(self)
    }
    
    @IBAction func deleteButton(sender: AnyObject) {
        if let subject = subject {
            SubjectCommData().wsSubjectComm_Del(subject.id) { (successful) in
                if successful {
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadSubject", object: nil)
                    self.dismissViewController(self)
                }
            }
        }
    }
}
