//
//  vkGraph.swift
//  CommHub
//
//  Created by Andrew Dzhur on 24/05/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation

class VkGraph {
    var likes: Int
    var comments: Int
    var share: Int
    var removed: Int
    var members: Int
    var membersLost: Int
    var dayString: String
    var isLast: Bool
    var isFuture: Bool
    
    init(likes: Int, comments: Int, share: Int, removed: Int, members: Int, membersLost: Int, dayString: String, isLast: Bool, isFuture: Bool) {
        self.likes = likes
        self.comments = comments
        self.share = share
        self.removed = removed
        self.members = members
        self.membersLost = membersLost
        self.dayString = dayString
        self.isLast = isLast
        self.isFuture = isFuture
    }
}