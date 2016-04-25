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
    var membersDifPercent: Int
    
    var increaseNew:Int
    var increaseDifPercent: Int
    
    var subscribed: Int
    var subscribedNew:Int
    var subscribedDifPercent: Int
    
    var unsubscribed: Int
    var unsubscribedNew: Int
    var unsubscribedDifPercent: Int
    
    var visitors: Int
    var visitorsNew: Int
    var visitorsDifPercent: Int
    
    var views: Int
    var viewsNew: Int
    var viewsDifPercent: Int
    
    var reach: Int
    var reachNew: Int
    var reachDifPercent: Int
    
    var reachSubscribers: Int
    var reachSubscribersNew: Int
    var reachSubscribersDifPercent: Int
    
    var postCount: Int
    var postCountNew: Int
    var postCountDifPercent: Int
    
    var likes: Int
    var likesNew: Int
    var likesDifPercent: Int
    
    var comments: Int
    var commentsNew: Int
    var commentsDifPercent: Int
    
    var reposts: Int
    var repostsNew: Int
    var repostsDifPercent: Int
    
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
       ,membersDifPercent: Int
        
       ,increaseNew: Int
       ,increaseDifPercent: Int
        
       ,subscribed: Int
       ,subscribedNew:Int
       ,subscribedDifPercent: Int
    
       ,unsubscribed: Int
       ,unsubscribedNew: Int
       ,unsubscribedDifPercent: Int
    
       ,visitors: Int
       ,visitorsNew: Int
       ,visitorsDifPercent: Int
    
       ,views: Int
       ,viewsNew: Int
       ,viewsDifPercent: Int
    
       ,reach: Int
       ,reachNew: Int
       ,reachDifPercent: Int
    
       ,reachSubscribers: Int
       ,reachSubscribersNew: Int
       ,reachSubscribersDifPercent: Int
    
       ,postCount: Int
       ,postCountNew: Int
       ,postCountDifPercent: Int
    
       ,likes: Int
       ,likesNew: Int
       ,likesDifPercent: Int
    
       ,comments: Int
       ,commentsNew: Int
       ,commentsDifPercent: Int
    
       ,reposts: Int
       ,repostsNew: Int
       ,repostsDifPercent: Int) {
        
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
        
        self.increaseNew = increaseNew
        self.increaseDifPercent = increaseDifPercent
        
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