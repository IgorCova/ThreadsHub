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
    @IBOutlet var countyPopUpButton: NSPopUpButton!
    @IBOutlet var phoneNumberTextField: NSTextField!
    @IBOutlet var countryCodeTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }

}
