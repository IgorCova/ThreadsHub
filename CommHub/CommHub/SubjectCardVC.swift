//
//  ThemesCardVC.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class SubjectCardVC: NSViewController {

    @IBOutlet var titleLabel: NSTextField!
    @IBOutlet var customView: NSView!
    @IBOutlet var subjectNameTextField: NSTextField!
    @IBOutlet var delete: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.3).CGColor
        customView.layer?.backgroundColor = NSColor.whiteColor().CGColor
    }
    
    func setCard(subject: Subject?, title: String, deleteButtonHide: Bool) {
        self.titleLabel.stringValue = title
        self.delete.hidden = deleteButtonHide
        if subject != nil {
            self.subjectNameTextField.stringValue = subject!.subjectName
        }
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        self.dismissController(self)
    }

    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissController(self)
    }
    
    @IBAction func deleteButton(sender: AnyObject) {
        self.dismissController(self)
    }
}
