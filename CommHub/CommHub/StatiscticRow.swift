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
    var membersDifPercent: Double
    
    var subscribed: Int
    var subscribedNew:Int
    var subscribedDifPercent: Double
    
    var unsubscribed: Int
    var unsubscribedNew: Int
    var unsubscribedDifPercent: Double
    
    var visitors: Int
    var visitorsNew: Int
    var visitorsDifPercent: Double
    
    var views: Int
    var viewsNew: Int
    var viewsDifPercent: Double
    
    var reach: Int
    var reachNew: Int
    var reachDifPercent: Double
    
    var reachSubscribers: Int
    var reachSubscribersNew: Int
    var reachSubscribersDifPercent: Double
    
    var postCount: Int
    var postCountNew: Int
    var postCountDifPercent: Double
    
    var likes: Int
    var likesNew: Int
    var likesDifPercent: Double
    
    var comments: Int
    var commentsNew: Int
    var commentsDifPercent: Double
    
    var reposts: Int
    var repostsNew: Int
    var repostsDifPercent: Double
    
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
       ,membersDifPercent: Double
    
       ,subscribed: Int
       ,subscribedNew:Int
       ,subscribedDifPercent: Double
    
       ,unsubscribed: Int
       ,unsubscribedNew: Int
       ,unsubscribedDifPercent: Double
    
       ,visitors: Int
       ,visitorsNew: Int
       ,visitorsDifPercent: Double
    
       ,views: Int
       ,viewsNew: Int
       ,viewsDifPercent: Double
    
       ,reach: Int
       ,reachNew: Int
       ,reachDifPercent: Double
    
       ,reachSubscribers: Int
       ,reachSubscribersNew: Int
       ,reachSubscribersDifPercent: Double
    
       ,postCount: Int
       ,postCountNew: Int
       ,postCountDifPercent: Double
    
       ,likes: Int
       ,likesNew: Int
       ,likesDifPercent: Double
    
       ,comments: Int
       ,commentsNew: Int
       ,commentsDifPercent: Double
    
       ,reposts: Int
       ,repostsNew: Int
       ,repostsDifPercent: Double) {
        
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
        self.membersDifPercent = membersDifPercent
        
        self.subscribed = subscribed
        self.subscribedNew = subscribedNew
        self.subscribedDifPercent = subscribedDifPercent
        
        self.unsubscribed = unsubscribed
        self.unsubscribedNew = unsubscribedNew
        self.unsubscribedDifPercent = unsubscribedDifPercent
        
        self.visitors = visitors
        self.visitorsNew = visitorsNew
        self.visitorsDifPercent = visitorsDifPercent
        
        self.views = views
        self.viewsNew = viewsNew
        self.viewsDifPercent = viewsDifPercent
        
        self.reach = reach
        self.reachNew = reachNew
        self.reachDifPercent = reachDifPercent
        
        self.reachSubscribers = reachSubscribers
        self.reachSubscribersNew = reachSubscribersNew
        self.reachSubscribersDifPercent = reachSubscribersDifPercent
        
        self.postCount = postCount
        self.postCountNew = postCountNew
        self.postCountDifPercent = postCountDifPercent
        
        self.likes = likes
        self.likesNew = likesNew
        self.likesDifPercent = likesDifPercent
        
        self.comments = comments
        self.commentsNew = commentsNew
        self.commentsDifPercent = commentsDifPercent
        
        self.reposts = reposts
        self.repostsNew = repostsNew
        self.repostsDifPercent = repostsDifPercent
    }
}