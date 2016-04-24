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
    func wsStaCommVKDaily_Report(completion : (dirSta: [StatisticRow], successful: Bool) -> Void) {
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["isPast": false]]
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/StaCommVKDaily_Report", parameters: prms, encoding: .JSON)
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
                            ,membersDifPercent: st["membersDifercent"].double ?? 0
                            
                            ,subscribed: st["subscribed"].int!
                            ,subscribedNew: st["subscribedNew"].int!
                            ,subscribedDifPercent: st["subscribedDifPercent"].double ?? 0
                            
                            ,unsubscribed: st["unsubscribed"].int!
                            ,unsubscribedNew: st["unsubscribedNew"].int!
                            ,unsubscribedDifPercent: st["unsubscribedDifPercent"].double ?? 0
                            
                            ,visitors: st["visitors"].int!
                            ,visitorsNew: st["visitorsNew"].int!
                            ,visitorsDifPercent: st["visitorsDifPercent"].double ?? 0
                            
                            ,views: st["views"].int!
                            ,viewsNew: st["viewsNew"].int!
                            ,viewsDifPercent: st["viewsDifPercent"].double ?? 0
                            
                            ,reach: st["reach"].int!
                            ,reachNew: st["reachNew"].int!
                            ,reachDifPercent: st["reachDifPercent"].double ?? 0
                            
                            ,reachSubscribers: st["reachSubscribers"].int!
                            ,reachSubscribersNew: st["reachSubscribersNew"].int ?? 0
                            ,reachSubscribersDifPercent: st["reachSubscribersDifPercent"].double ?? 0
                            
                            ,postCount: st["postCount"].int!
                            ,postCountNew: st["postCountNew"].int!
                            ,postCountDifPercent: st["postCountDifPercent"].double ?? 0
                            
                            ,likes: st["likes"].int!
                            ,likesNew: st["likesNew"].int!
                            ,likesDifPercent: st["likesDifPercent"].double ?? 0
                            
                            ,comments: st["comments"].int!
                            ,commentsNew: st["commentsNew"].int!
                            ,commentsDifPercent: st["commentsDifPercent"].double ?? 0
                            
                            ,reposts: st["reposts"].int!
                            ,repostsNew: st["repostsNew"].int!
                            ,repostsDifPercent: st["repostsDifPercent"].double ?? 0)
                        
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
