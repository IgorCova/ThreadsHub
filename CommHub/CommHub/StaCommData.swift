//
//  CommStatData.swift
//  CommHub
//
//  Created by Andrew Dzhur on 17/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class StaCommData {
    
    func wsStaCommVKDaily_ReportDay(completion : (dirSta: [StatisticRow], successful: Bool) -> Void) {
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID]
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/StaCommVKDaily_ReportDay", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    var stats = [StatisticRow]()
                    for st in json {
                        let sta = StatisticRow(
                              comm_id: st["comm_id"].int!
                             ,comm_name: st["comm_name"].stringValue
                             ,comm_photoLink: st["comm_photoLink"].stringValue
                             ,comm_groupID: st["comm_groupID"].int!
                             ,subjectComm_name: st["subjectComm_name"].stringValue
                             ,areaComm_code: st["areaComm_code"].stringValue
                             ,adminComm_fullName: st["adminComm_fullName"].stringValue
                             ,adminComm_linkFB: st["adminComm_linkFB"].stringValue
                             ,members: st["members"].int!
                             ,membersNew: st["membersNew"].int!
                             ,membersNewPercent: st["membersNewPercent"].double!
                             ,subscribed: st["subscribed"].int!
                             ,subscribedNew: st["subscribedNew"].int!
                             ,subscribedNewPercent: st["subscribedNewPercent"].double!
                             ,unsubscribed: st["unsubscribed"].int!
                             ,unsubscribedNew: st["unsubscribedNew"].int!
                             ,unsubscribedNewPercent: st["unsubscribedNewPercent"].double!
                             ,visitors: st["visitors"].int!
                             ,visitorsNew: st["visitorsNew"].int!
                             ,visitorsNewPercent: st["visitorsNewPercent"].double!
                             ,views: st["views"].int!
                             ,viewsNew: st["viewsNew"].int!
                             ,viewsNewPercent: st["viewsNewPercent"].double!
                             ,reach: st["reach"].int!
                             ,reachNew: st["reachNew"].int!
                             ,reachNewPercent: st["reachNewPercent"].double!
                             ,reachSubscribers: st["reachSubscribers"].int!
                             ,reachSubscribersNew: st["reachSubscribersNew"].int!
                             ,reachSubscribersNewPercent: st["reachSubscribersNewPercent"].double!
                             ,postCount: st["postCount"].int!
                             ,postCountNew: st["postCountNew"].int!
                             ,postCountNewPercent: st["postCountNewPercent"].double!
                             ,likes: st["likes"].int!
                             ,likesNew: st["likesNew"].int!
                             ,likesNewPercent: st["likesNewPercent"].double!
                             ,comments: st["comments"].int!
                             ,commentsNew: st["commentsNew"].int!
                             ,commentsNewPercent: st["commentsNewPercent"].double!
                             ,reposts: st["reposts"].int!
                             ,repostsNew: st["repostsNew"].int!
                             ,repostsNewPercent: st["repostsNewPercent"].double!)
                        
                        stats.append(sta)
                    }
                    
                    completion(dirSta: stats, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(dirSta: [StatisticRow](), successful: false)
                }

        }
    }

}
