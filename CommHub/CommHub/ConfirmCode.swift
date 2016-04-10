//
//  ConfirmCodeViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 09/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class ConfirmCode: NSViewController {

    @IBOutlet var phoneNumberTextField: NSTextField!
    @IBOutlet var codeTextField: NSTextField!
    var requestCode: SessionReqRes?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if  identifier == "toMainStatistics" {
            if requestCode?.code == codeTextField.stringValue {
            if let req = requestCode {
                SessionData().wsSessionSave(req.id) { (own, isNew, successful) in
                    if successful {
                        if own.id > 0 {
                            let owner = OwnerHubEntryFields(id: own.id, sessionId: own.sessionId)
                            OwnerHubData().saveOwnerHubEntry(owner)
                        }
                    }
                }
            }
            return true
            }
            return false
        } else {
            return true
        }
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "backToRegistration" {
            (segue as! RegistrationSegue).transitionEffect = .SlideRight
        } else if segue.identifier == "toMainStatistics" {
            (segue as! RegistrationSegue).transitionEffect = .Crossfade
        }
        
    }
    
/*
    func getSession() {
        if requestCode?.code == codeTextField.stringValue {
            if let req = requestCode {
                SessionData().wsSessionSave(req.id) { (own, isNew, successful) in
                    if successful {
                        if own.id > 0 {
                            let owner = OwnerHubEntryFields(id: own.id, sessionId: own.sessionId)
                            OwnerHubData().saveOwnerHubEntry(owner)
                        }
                    }
                }
            }
        }
    }
 */

}
