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
    
    func wsStaComm_Report(dateType: String, completion : (dirSta: [StatisticRow], successful: Bool) -> Void) {
        var prms : [String : AnyObject] = [:]
        var URLString = "\(HubService)/StaCommDaily_Report"
        
        switch dateType {
        case "Day":
            prms = ["Session": MySessionID, "DID": MyDID, "Params": ["isPast": false]]
            URLString = "\(HubService)/StaCommDaily_Report"
        case "Yesterday":
            prms = ["Session": MySessionID, "DID": MyDID, "Params": ["isPast": true]]
            URLString = "\(HubService)/StaCommDaily_Report"
        case "Week":
            prms = ["Session": MySessionID, "DID": MyDID]
            URLString = "\(HubService)/StaCommDaily_Report"
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
    

    
    func wsStaCommOK_Report(dateType: String, completion : (dirSta: [StatisticRow], successful: Bool) -> Void) {
        var prms : [String : AnyObject] = [:]
        var URLString = "\(HubService)/StaCommOKDaily_Report"
        
        switch dateType {
        case "Day":
            prms = ["Session": MySessionID, "DID": MyDID, "Params": ["isPast": false]]
            URLString = "\(HubService)/StaCommOKDaily_Report"
        case "Yesterday":
            prms = ["Session": MySessionID, "DID": MyDID, "Params": ["isPast": true]]
            URLString = "\(HubService)/StaCommOKDaily_Report"
        case "Week":
            prms = ["Session": MySessionID, "DID": MyDID]
            URLString = "\(HubService)/StaCommOKWeekly_Report"
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
    
//    FIXME: Исправить названия -> Поговорить с Игорем
/*
    func wsStaProjectDaily_Report(/*dateType: String,*/ completion : (dirSta: [StatisticRow], successful: Bool) -> Void) {
        var prms : [String : AnyObject] = [:]
        let URLString = "\(HubService)/StaCommDaily_Report"
        /*
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
         */
        
        prms = ["Session": MySessionID, "DID": MyDID, "Params": ["isPast": false]]
        
        Alamofire.request(.POST, URLString, parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                
//                FIXME: Нелогичная проверка, при получении, мы еще раз проверяем -> Спросить Игоря
                
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
*/

    func getSta(data: AnyObject) -> [StatisticRow] {
        let json = JSON(data)["Data"].arrayValue
        var stats = [StatisticRow]()
        for st in json {
            let sta = StatisticRow(
                comm_id: st["comm_id"].intValue
                ,projectHub_id: st["projectHub_id"].intValue
                ,comm_name: st["comm_name"].stringValue
                ,projectHub_name: st["projectHub_name"].stringValue
                ,comm_photoLink: st["comm_photoLink"].stringValue
                ,comm_photoLinkBig: st["comm_photoLinkBig"].stringValue
                ,comm_groupID: st["comm_groupID"].intValue
                ,subjectComm_name: st["subjectComm_name"].stringValue
                ,areaComm_code: st["areaComm_code"].stringValue
                
                ,adminComm_fullName: st["adminComm_fullName"].stringValue
                ,adminComm_linkFB: st["adminComm_linkFB"].stringValue
                
                ,members: st["members"].intValue
                
                ,increase: st["increase"].intValue
                ,increaseNew: st["increaseNew"].intValue
                ,increaseOld: st["increaseOld"].intValue
                ,increaseDifPercent: st["increaseDifPercent"].intValue
                
                ,reachNew: st["reachNew"].intValue
                ,reachDifPercent: st["reachDifPercent"].intValue
                
                ,postCountNew: st["postCountNew"].intValue
                ,postCountDifPercent: st["postCountDifPercent"].intValue
                
                ,likesNew: st["likesNew"].intValue
                ,likesDifPercent: st["likesDifPercent"].intValue
                
                ,commentsNew: st["commentsNew"].intValue
                ,commentsDifPercent: st["commentsDifPercent"].intValue
                
                ,resharesNew: st["resharesNew"].intValue
                ,resharesDifPercent: st["resharesDifPercent"].intValue)
            
            stats.append(sta)
        }
        return stats
    }
    


}
