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
    var comm_photoLinkBig: String
    var comm_groupID: Int
    
    var subjectComm_name: String
    var areaComm_code: String
    
    var adminComm_fullName: String
    var adminComm_linkFB: String
    
    var members: Int
    
    var increase:Int
    var increaseNew:Int
    var increaseOld: Int
    var increaseDifPercent: Int
    
    var reachNew: Int
    var reachDifPercent: Int
    
    var postCountNew: Int
    var postCountDifPercent: Int
    
    var likesNew: Int
    var likesDifPercent: Int
    
    var commentsNew: Int
    var commentsDifPercent: Int

    var resharesNew: Int
    var resharesDifPercent: Int
    
    init(
        comm_id: Int
       ,comm_name: String
       ,comm_photoLink: String
       ,comm_photoLinkBig: String
       ,comm_groupID: Int
    
       ,subjectComm_name: String
       ,areaComm_code: String
    
       ,adminComm_fullName: String
       ,adminComm_linkFB: String
    
        ,members: Int
        
       ,increase:Int
       ,increaseNew:Int
       ,increaseOld: Int
       ,increaseDifPercent: Int
    
       ,reachNew: Int
       ,reachDifPercent: Int

       ,postCountNew: Int
       ,postCountDifPercent: Int
    
       ,likesNew: Int
       ,likesDifPercent: Int
    
       ,commentsNew: Int
       ,commentsDifPercent: Int
    
       ,resharesNew: Int
       ,resharesDifPercent: Int) {
        
        self.comm_id = comm_id
        self.comm_name = comm_name
        self.comm_photoLink = comm_photoLink
        self.comm_photoLinkBig = comm_photoLinkBig
        self.comm_groupID = comm_groupID
        
        self.subjectComm_name = subjectComm_name
        self.areaComm_code = areaComm_code
        
        self.adminComm_fullName = adminComm_fullName
        self.adminComm_linkFB = adminComm_linkFB
        
        self.members = members
        
        self.increase = increase
        self.increaseNew = increaseNew
        self.increaseOld = increaseOld
        self.increaseDifPercent = increaseDifPercent
        
        self.reachNew = reachNew
        self.reachDifPercent = reachDifPercent

        self.postCountNew = postCountNew
        self.postCountDifPercent = postCountDifPercent
        
        self.likesNew = likesNew
        self.likesDifPercent = likesDifPercent
        
        self.commentsNew = commentsNew
        self.commentsDifPercent = commentsDifPercent

        self.resharesNew = resharesNew
        self.resharesDifPercent = resharesDifPercent
    }
}