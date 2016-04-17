//
//  Community.swift
//  CommHub
//
//  Created by Andrew Dzhur on 02/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import AppKit

class Comm {
    var id: Int
    var name: String
    //var communityProfileImage: NSImage?
    var subjectID: Int
    var subjectName: String
    var adminID: Int
    var adminName: String
    var link = ""
    var photoLink: String
    var groupID: Int
    
    init(id: Int, name: String, subject: SubjectComm, admin: AdminComm/*, profileImage: NSImage?*/, link: String, groupID: Int, photoLink: String) {
        self.id = id
        self.name = name
        self.subjectID = subject.id
        self.subjectName = subject.name
        self.adminID = admin.id
        self.adminName = admin.lastName + " " + admin.firstName
        //self.communityProfileImage = profileImage
        self.photoLink = photoLink
        self.link = link
        self.groupID = groupID
    }
    
}
