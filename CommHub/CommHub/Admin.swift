//
//  Admins.swift
//  CommHub
//
//  Created by Andrew Dzhur on 31/03/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import AppKit

class Admin {
    var id: Int
    var firstName: String?
    var secondName: String?
    var profileImage: NSImage?
    var phoneNumber: String?
    var link = ""
    
    init(id: Int, firstName: String, secondName:String, profileImage: NSImage?, phoneNumber: String, link: String) {
        
        self.id = id
        self.firstName = firstName
        self.secondName = secondName
        self.profileImage = profileImage
        self.phoneNumber = phoneNumber
        self.link = link
    }
}