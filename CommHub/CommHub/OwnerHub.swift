//
//  Member.swift
//  Threads
//
//  Created by Igor Cova on 30/01/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//

import Foundation

class OwnerHub {
    var id : Int
    var firstName : String
    var lastName : String?
    var phone : String
    var linkFB : String
    
    var fullName : String {
        return "\(firstName) \(lastName ?? "")"
    }
    
    init (id: Int, firstName : String, lastName : String?, phone : String, linkFB : String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.linkFB = linkFB
    }
}

class OwnerHubEntryFields {
    var id : Int
    var sessionId: String
    
    init (id: Int, sessionId: String) {
        self.id = id
        self.sessionId = sessionId
    }
}