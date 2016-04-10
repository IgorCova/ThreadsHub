//
//  Log+CoreDataProperties.swift
//  Threads
//
//  Created by Igor Cova on 21/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Log {
    @NSManaged var ownerHubID: NSNumber?
    @NSManaged var sessionID: String?
}
