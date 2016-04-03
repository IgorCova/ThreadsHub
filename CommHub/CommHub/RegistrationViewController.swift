//
//  RegistrationViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 03/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class RegistrationViewController: NSViewController {

    @IBOutlet var titleLabel: NSTextField!
    @IBOutlet var countyPopUpButton: NSPopUpButton!
    @IBOutlet var numberTextField: NSTextField!
    @IBOutlet var countryCodeTextField: NSTextField!
    var requestResult: SessionReqRes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeSessionRequest()
    }
    
    @IBAction func continueButton(sender: AnyObject) {
        
    }
    
    func makeSessionRequest() {
        let phone = "+7 (926) 430-82-72".removePunctMarks()//self.numberTextField.stringValue.removePunctMarks()
        SessionData().wsSessionReqSave(phone) { (reqres, successful) in
            if successful {
                self.requestResult = reqres
            }
        }
    }
    
    func getSession() {
        if 1 == 1 {
            if let req = requestResult {
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
    
    

}
