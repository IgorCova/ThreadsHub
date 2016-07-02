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
    var subjectID: Int
    var subjectName: String
    var adminID: Int
    var adminName: String
    var link = ""
    var photoLink: String
    var groupID: Int
    
    init(id: Int, name: String, subject: SubjectComm, admin: AdminComm, link: String, groupID: Int, photoLink: String) {
        self.id = id
        self.name = name
        self.subjectID = subject.id
        self.subjectName = subject.name
        self.adminID = admin.id
        self.adminName = admin.lastName + " " + admin.firstName
        self.photoLink = photoLink
        self.link = link
        self.groupID = groupID
    }
    
}

class CommInstance {
    var id: Int
    var name: String
    var subjectName: String
    var areaCode: String
    var adminName: String
    var adminLink: String
    var link: String
    var photoLink: String
    var photoLinkBig: String
    var groupID: Int
    var countMembers: Int
    var countWoman: Int
    var countWomanPercent: Int
    var countMen: Int
    var countMenPercent: Int

    init(
        id: Int,
        name: String,
        subjectName: String,
        areaCode: String,
        adminName: String,
        adminLink: String,
        link: String,
        photoLink: String,
        photoLinkBig: String,
        groupID: Int,
        countMembers: Int,
        countWoman: Int,
        countWomanPercent: Int,
        countMen: Int,
        countMenPercent: Int) {
        
        self.id = id
        self.name = name
        self.subjectName = subjectName
        self.areaCode = areaCode
        self.adminName = adminName
        self.adminLink = adminLink
        self.link = link
        self.photoLink = photoLink
        self.photoLinkBig = photoLinkBig
        self.groupID = groupID
        self.countMembers = countMembers
        self.countWoman = countWoman
        self.countWomanPercent = countWomanPercent
        self.countMen = countMen
        self.countMenPercent = countMenPercent
    }
    
}
