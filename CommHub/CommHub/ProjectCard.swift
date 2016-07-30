//
//  ProjectCard.swift
//  CommHub
//
//  Created by Andrew Dzhur on 30/07/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class ProjectCardViewController: NSViewController {

    @IBOutlet var projectNameTextField: NSTextField!
    @IBOutlet var deleteButton: NSButton!
    @IBOutlet var saveButton: NSButton!
    
    var project: Project?
    var deleteButtonHide: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        deleteButton.hidden = deleteButtonHide!
        
        if let project = self.project {
            projectNameTextField.stringValue = project.name
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        if deleteButtonHide == true {
            self.saveButton.frame.origin.x = 125
        }
    }
    
    func setCard(project: Project?, deleteButtonHide: Bool) {
        self.project = project
        self.deleteButtonHide = deleteButtonHide
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        if projectNameTextField.stringValue.isEmpty {
            projectNameTextField.layer!.borderColor = NSColor.redColor().CGColor
            projectNameTextField.layer!.borderWidth = 1
        } else {
            projectNameTextField.layer!.borderWidth = 0
            saveInfo()
            
            ProjectHubData().wsProjectHub_Save(project!) { (successful) in
                
                if successful {
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadProjects", object: nil)
//                    NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
                    self.dismissViewController(self)
                }
            }
        }
    }
    
    func saveInfo() {
        // Add alert about empty name.
        if project == nil {
            project = Project(
                id: 0
                ,name: projectNameTextField.stringValue)
        } else {
            project?.name = projectNameTextField.stringValue
        }
    }
    
    @IBAction func deleteAction(sender: AnyObject) {
        if let project = project {
            ProjectHubData().wsProjectHub_Del(project.id) { (successful) in
                if successful {
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadProjects", object: nil)
//                    NSNotificationCenter.defaultCenter().postNotificationName("reloadSta", object: nil)
                    self.dismissViewController(self)
                }
            }
        }
    }
}
