//
//  RegistrationViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 03/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class Registration: NSViewController {

    @IBOutlet var titleLabel: NSTextField!
    @IBOutlet var phoneNumberTextField: NSTextField!
    @IBOutlet var continueButton: NSButton!
    
    var sessionReqRes: SessionReqRes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.view.wantsLayer = true
        //self.view.layer?.backgroundColor = NSColor.init(hexString: "245082").CGColor
        //self.view.window?.titlebarAppearsTransparent = true
        // self.view.window?.backgroundColor = NSColor.init(hexString: "245082")
        self.view.window?.toolbar?.visible = false
        self.setStyleMask()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    override var representedObject: AnyObject? {
        didSet {
        }
    }
    
    func setStyleMask() {
        self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask  // | NSResizableWindowMask
        self.view.window?.titlebarAppearsTransparent = true
        // self.view.window?.backgroundColor = NSColor.init(hexString: "2E6597")
        // self.view.window?.titleVisibility = .Hidden
    }
    
    @IBAction func btnContinueClick(sender: AnyObject) {
        let phone = phoneNumberTextField.stringValue.removePunctMarks()
        
        if (phone.characters.count != 11) {
            let alert:NSAlert = NSAlert();
            alert.messageText = NSLocalizedString("Warning", comment: "") //"Предупреждение"
            alert.informativeText = NSLocalizedString("Warning.PhoneNumber", comment: "") //"Не правильно введен номер телефона"
            alert.runModal()
            
            return
        } else {
            SessionData().wsSessionReqSave(phone) { (reqres, successful) in
                if successful {
                    self.sessionReqRes = reqres
                    self.performSegueWithIdentifier("toConfirmCode", sender: self)
                } else {
                    let alert:NSAlert = NSAlert();
                    alert.messageText = NSLocalizedString("AuthorizationError", comment: "") //"Ошибка авторизации"
                    alert.informativeText = NSLocalizedString("UnknownError", comment: "")//"Произошла неизвестная ошибка"
                    alert.runModal()
                }
            }
        }
    }

    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toConfirmCode" {
            (segue as! RegistrationSegue).transitionEffect = .SlideLeft
            let destinationViewController = segue.destinationController as! ConfirmCode
            destinationViewController.sessionReqRes = self.sessionReqRes
            destinationViewController.phone = self.phoneNumberTextField.stringValue
        }
    }
}
