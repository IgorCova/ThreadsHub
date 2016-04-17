//
//  StatiscticRow.swift
//  CommHub
//
//  Created by Andrew Dzhur on 16/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation

class StatisticRow {
    var comm_id: Int
    var comm_name: String
    var comm_photoLink: String
    var comm_groupID: Int
    
    var subjectComm_name: String
    var areaComm_code: String
    
    var adminComm_fullName: String
    var adminComm_linkFB: String
    
    var members: Int
    var membersNew: Int
    var membersNewPercent: Double
    
    var subscribed: Int
    var subscribedNew:Int
    var subscribedNewPercent: Double
    
    var unsubscribed: Int
    var unsubscribedNew: Int
    var unsubscribedNewPercent: Double
    
    var visitors: Int
    var visitorsNew: Int
    var visitorsNewPercent: Double
    
    var views: Int
    var viewsNew: Int
    var viewsNewPercent: Double
    
    var reach: Int
    var reachNew: Int
    var reachNewPercent: Double
    
    var reachSubscribers: Int
    var reachSubscribersNew: Int
    var reachSubscribersNewPercent: Double
    
    var postCount: Int
    var postCountNew: Int
    var postCountNewPercent: Double
    
    var likes: Int
    var likesNew: Int
    var likesNewPercent: Double
    
    var comments: Int
    var commentsNew: Int
    var commentsNewPercent: Double
    
    var reposts: Int
    var repostsNew: Int
    var repostsNewPercent: Double
    
    init(
        comm_id: Int
       ,comm_name: String
       ,comm_photoLink: String
       ,comm_groupID: Int
    
       ,subjectComm_name: String
       ,areaComm_code: String
    
       ,adminComm_fullName: String
       ,adminComm_linkFB: String
    
       ,members: Int
       ,membersNew: Int
       ,membersNewPercent: Double
    
       ,subscribed: Int
       ,subscribedNew:Int
       ,subscribedNewPercent: Double
    
       ,unsubscribed: Int
       ,unsubscribedNew: Int
       ,unsubscribedNewPercent: Double
    
       ,visitors: Int
       ,visitorsNew: Int
       ,visitorsNewPercent: Double
    
       ,views: Int
       ,viewsNew: Int
       ,viewsNewPercent: Double
    
       ,reach: Int
       ,reachNew: Int
       ,reachNewPercent: Double
    
       ,reachSubscribers: Int
       ,reachSubscribersNew: Int
       ,reachSubscribersNewPercent: Double
    
       ,postCount: Int
       ,postCountNew: Int
       ,postCountNewPercent: Double
    
       ,likes: Int
       ,likesNew: Int
       ,likesNewPercent: Double
    
       ,comments: Int
       ,commentsNew: Int
       ,commentsNewPercent: Double
    
       ,reposts: Int
       ,repostsNew: Int
       ,repostsNewPercent: Double) {
        
        self.comm_id = comm_id
        self.comm_name = comm_name
        self.comm_photoLink = comm_photoLink
        self.comm_groupID = comm_groupID
        
        self.subjectComm_name = subjectComm_name
        self.areaComm_code = areaComm_code
        
        self.adminComm_fullName = adminComm_fullName
        self.adminComm_linkFB = adminComm_linkFB
        
        self.members = members
        self.membersNew = membersNew
        self.membersNewPercent = membersNewPercent
        
        self.subscribed = subscribed
        self.subscribedNew = subscribedNew
        self.subscribedNewPercent = subscribedNewPercent
        
        self.unsubscribed = unsubscribed
        self.unsubscribedNew = unsubscribedNew
        self.unsubscribedNewPercent = unsubscribedNewPercent
        
        self.visitors = visitors
        self.visitorsNew = visitorsNew
        self.visitorsNewPercent = visitorsNewPercent
        
        self.views = views
        self.viewsNew = viewsNew
        self.viewsNewPercent = viewsNewPercent
        
        self.reach = reach
        self.reachNew = reachNew
        self.reachNewPercent = reachNewPercent
        
        self.reachSubscribers = reachSubscribers
        self.reachSubscribersNew = reachSubscribersNew
        self.reachSubscribersNewPercent = reachSubscribersNewPercent
        
        self.postCount = postCount
        self.postCountNew = postCountNew
        self.postCountNewPercent = postCountNewPercent
        
        self.likes = likes
        self.likesNew = likesNew
        self.likesNewPercent = likesNewPercent
        
        self.comments = comments
        self.commentsNew = commentsNew
        self.commentsNewPercent = commentsNewPercent
        
        self.reposts = reposts
        self.repostsNew = repostsNew
        self.repostsNewPercent = repostsNewPercent
    }
}