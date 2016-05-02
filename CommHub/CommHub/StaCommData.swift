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
    
    func wsStaCommVK_Report(dateType: String, completion : (dirSta: [StatisticRow], successful: Bool) -> Void) {
        var prms : [String : AnyObject] = [:]
        var URLString = "\(HubService)/StaCommVKDaily_Report"
        
        switch dateType {
            case "Day":
                prms = ["Session": MySessionID, "DID": MyDID, "Params": ["isPast": false]]
                URLString = "\(HubService)/StaCommVKDaily_Report"
            case "Yesterday":
                prms = ["Session": MySessionID, "DID": MyDID, "Params": ["isPast": true]]
                URLString = "\(HubService)/StaCommVKDaily_Report"
            case "Week":
                prms = ["Session": MySessionID, "DID": MyDID]
                URLString = "\(HubService)/StaCommVKWeekly_Report"
        default:
            break
        }
        print (URLString)
        
        Alamofire.request(.POST, URLString, parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                
                switch response.result {
                case .Success(let data):
                    let stats: [StatisticRow] = self.getSta(data)
                    completion(dirSta: stats, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(dirSta: [StatisticRow](), successful: false)
                }
        }
    }
    
    func getSta(data: AnyObject) -> [StatisticRow] {
        let json = JSON(data)["Data"].arrayValue
        var stats = [StatisticRow]()
        for st in json {
            let sta = StatisticRow(
                comm_id: st["comm_id"].int ?? 0
                ,comm_name: st["comm_name"].stringValue
                ,comm_photoLink: st["comm_photoLink"].stringValue
                ,comm_groupID: st["comm_groupID"].int ?? 0
                ,subjectComm_name: st["subjectComm_name"].stringValue
                ,areaComm_code: st["areaComm_code"].stringValue
                ,adminComm_fullName: st["adminComm_fullName"].stringValue
                ,adminComm_linkFB: st["adminComm_linkFB"].stringValue
                
                ,members: st["members"].int ?? 0
                ,membersNew: st["membersNew"].int ?? 0
                ,membersDifPercent: st["membersDifercent"].int ?? 0
                
                ,increaseNew: st["increaseNew"].int ?? 0
                ,increaseDifPercent: st["increaseDifPercent"].int ?? 0
                ,subscribed: st["subscribed"].int ?? 0
                ,subscribedNew: st["subscribedNew"].int ?? 0
                ,subscribedDifPercent: st["subscribedDifPercent"].int ?? 0
                
                ,unsubscribed: st["unsubscribed"].int ?? 0
                ,unsubscribedNew: st["unsubscribedNew"].int ?? 0
                ,unsubscribedDifPercent: st["unsubscribedDifPercent"].int ?? 0
                
                ,visitors: st["visitors"].int ?? 0
                ,visitorsNew: st["visitorsNew"].int ?? 0
                ,visitorsDifPercent: st["visitorsDifPercent"].int ?? 0
                
                ,views: st["views"].int ?? 0
                ,viewsNew: st["viewsNew"].int ?? 0
                ,viewsDifPercent: st["viewsDifPercent"].int ?? 0
                
                ,reach: st["reach"].int ?? 0
                ,reachNew: st["reachNew"].int ?? 0
                ,reachDifPercent: st["reachDifPercent"].int ?? 0
                
                ,reachSubscribers: st["reachSubscribers"].int ?? 0
                ,reachSubscribersNew: st["reachSubscribersNew"].int ?? 0
                ,reachSubscribersDifPercent: st["reachSubscribersDifPercent"].int ?? 0
                
                ,postCount: st["postCount"].int ?? 0
                ,postCountNew: st["postCountNew"].int ?? 0
                ,postCountDifPercent: st["postCountDifPercent"].int ?? 0
                
                ,likes: st["likes"].int ?? 0
                ,likesNew: st["likesNew"].int ?? 0
                ,likesDifPercent: st["likesDifPercent"].int ?? 0
                
                ,comments: st["comments"].int ?? 0
                ,commentsNew: st["commentsNew"].int ?? 0
                ,commentsDifPercent: st["commentsDifPercent"].int ?? 0
                
                ,reposts: st["reposts"].int ?? 0
                ,repostsNew: st["repostsNew"].int ?? 0
                ,repostsDifPercent: st["repostsDifPercent"].int ?? 0)
            
            stats.append(sta)
        }
        return stats
    }
    


}
