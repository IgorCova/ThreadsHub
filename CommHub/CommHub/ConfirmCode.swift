//
//  ConfirmCodeViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 09/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class ConfirmCode: NSViewController {

    @IBOutlet weak var lblPhone: NSTextField!
    @IBOutlet var codeTextField: NSTextField!
    var sessionReqRes: SessionReqRes?
    var phone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblPhone.stringValue = phone
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.wantsLayer = true
        // self.view.layer?.backgroundColor = NSColor.init(hexString: "245082").CGColor
        //self.view.window?.titlebarAppearsTransparent = true
        // self.view.window?.backgroundColor = NSColor.init(hexString: "245082")
        self.view.window?.toolbar?.visible = false
    }
    
    override var representedObject: AnyObject? {
        didSet {
        }
    }
    
    @IBAction func btnConfirmClick(sender: AnyObject) {
        if sessionReqRes?.code == codeTextField.stringValue {
            if let req = sessionReqRes {
                SessionData().wsSessionSave(req.id) { (own, isNew, successful) in
                    if successful {
                        if own.id > 0 {
                            let owner = OwnerHubEntryFields(id: own.id, sessionId: own.sessionId)
                            OwnerHubData().saveOwnerHubEntry(owner)
    
                            NSApplication.sharedApplication().mainWindow?.close()
                            self.performSegueWithIdentifier("confirmed", sender: self)
                        }
                    }
                }
            }
        }

    }
    
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "backToRegistration" {
            (segue as! RegistrationSegue).transitionEffect = .SlideRight
        }
    }
}
