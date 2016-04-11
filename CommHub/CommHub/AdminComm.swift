//
//  Admins.swift
//  CommHub
//
//  Created by Andrew Dzhur on 31/03/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import AppKit

class AdminComm {
    var id: Int
    var firstName: String
    var lastName: String
    //var profileImage: NSImage?
    var phone: String
    var linkFB: String?
    
    init(id: Int, firstName: String, lastName: String /*,profileImage: NSImage?*/, phone: String, linkFB: String?) {
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        //self.profileImage = profileImage
        self.phone = phone
        self.linkFB = linkFB
    }
    
    init(firstName: String, lastName: String, linkFB: String?) {
        self.id = 0
        self.firstName = firstName
        self.lastName = lastName
        self.phone = ""
        self.linkFB = linkFB
    }
}