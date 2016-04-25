//
//  Profile.swift
//  CommHub
//
//  Created by Andrew Dzhur on 23/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa
import AppKit

class Profile: NSViewController {

    @IBOutlet var profileImage: NSImageView!
    @IBOutlet var firstName: NSTextField!
    @IBOutlet var lastName: NSTextField!
    @IBOutlet var phoneNumber: NSTextField!
    @IBOutlet var linkToFacebook: NSTextField!
    
    var owner: OwnerHub?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        //let colorTop = NSColor.init(hexString: "244566").CGColor
        //let colorBottom = NSColor.init(hexString: "2E6597").CGColor
        //let gradient  = CAGradientLayer()
        //gradient.colors = [ colorTop, colorBottom]
        //gradient.locations = [ 0.0, 1.0]
        //view.layer = gradient
        
        self.profileImage.layer!.cornerRadius = self.profileImage.frame.size.height/2
        self.profileImage.layer!.masksToBounds = true
        
        OwnerHubData().wsOwnerHub_Read { (owner, successful) in
            if successful {
                self.owner = owner
                
                self.firstName.stringValue = self.owner?.firstName ?? ""
                self.lastName.stringValue = self.owner?.lastName ?? ""
                self.phoneNumber.stringValue = self.owner?.phone ?? ""
                self.linkToFacebook.stringValue = self.owner?.linkFB ?? ""
                
                let urlImage = "https://graph.facebook.com/\( self.owner?.linkFB ?? "0")/picture?type=normal"
                self.profileImage.imageFromUrl(urlImage)
                
            }
        }
    }
    
    @IBAction func btnSaveClick(sender: AnyObject) {
        owner?.firstName = self.firstName.stringValue
        owner?.lastName = self.lastName.stringValue
        owner?.linkFB = self.linkToFacebook.stringValue
        
        OwnerHubData().wsOwnerHub_Save(owner!) { (successful) in
            if successful {
                self.dismissViewController(self)
            }
        }
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        setStyleMask()
    }
    
    func setStyleMask() {
        self.view.window!.styleMask = NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask  // | NSResizableWindowMask
        self.view.window?.titlebarAppearsTransparent = true
        // self.view.window?.backgroundColor = NSColor.init(hexString: "2E6597")
        self.view.window?.titleVisibility = .Hidden
    }

}



