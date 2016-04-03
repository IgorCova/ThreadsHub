//
//  Community.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import AppKit

class Community {
    var id: Int
    var communityName: String
    var communityProfileImage: NSImage?
    var subjectID: Int
    var subjectName: String
    var adminID: Int
    var adminName: String
    var link = ""
    
    init(id: Int, communityName: String, subject: Subject, admin: Admin, profileImage: NSImage?, link: String) {
        self.id = id
        self.communityName = communityName
        self.subjectID = subject.id
        self.subjectName = subject.subjectName
        self.adminID = admin.id
        self.adminName = admin.firstName! + " " + admin.secondName!
        self.communityProfileImage = profileImage
        self.link = link
    }
    
}
