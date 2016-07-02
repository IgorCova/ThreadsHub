//
//  CommunityData.swift
//  CommHub
//
//  Created by Andrew Dzhur on 03/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CommData{
    func wsComm_ReadDict(completion: (dirComm: [Comm], successful: Bool) -> Void) {
        // prms -> Parametrs
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID]
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/Comm_ReadDict", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    var communitiesComm = [Comm]()
                    for co in json {
                        let subjectComm = SubjectComm(id: co["subjectCommID"].int!, name: co["subjectCommID_name"].stringValue)
                        let adminComm = AdminComm(
                            id: co["adminCommID"].int!
                           ,firstName: co["adminCommID_firstName"].stringValue
                           ,lastName: co["adminCommID_lastName"].stringValue
                           ,phone: co["adminCommID_phone"].stringValue
                           ,linkFB: co["adminCommID_linkFB"].stringValue)
                        
                        let communityComm = Comm(id: co["id"].int!, name: co["name"].stringValue, subject: subjectComm, admin: adminComm, link: co["link"].stringValue, groupID: co["groupID"].int!, photoLink: co["photoLink"].stringValue)
                        
                        communitiesComm.append(communityComm)
                    }
                    
                    completion(dirComm: communitiesComm, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(dirComm: [Comm](), successful: false)
                }
        }
    }
    
    func wsComm_Read(commID: Int, completion: (comm: CommInstance?, successful: Bool) -> Void) {
        // prms -> Parametrs
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["id": commID]]
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/Comm_Read", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionaryValue
                        let comm = CommInstance(
                            id:                json["id"]!.int ?? 0,
                            name:              json["name"]?.string ?? "",
                            subjectName:       json["subjectCommID_name"]?.string ?? "",
                            areaCode:          json["areaCommID_code"]?.string ?? "",
                            
                            adminName:         json["adminCommID_Name"]?.string ?? "",
                            adminLink:         json["adminCommID_linkFB"]?.string ?? "",
                            
                            link:              json["link"]?.string ?? "",
                            
                            photoLink:         json["photoLink"]?.string ?? "",
                            photoLinkBig:      json["photoLinkBig"]?.string ?? "",
                            
                            groupID:           json["groupID"]?.int ?? 0,
                            
                            countMembers:      json["countMembers"]?.int ?? 0,
                            countWoman:        json["countWoman"]?.int ?? 0,
                            countWomanPercent: json["countWomanPercent"]?.int ?? 0,
                            countMen:          json["countMen"]?.int ?? 0,
                            countMenPercent:   json["countMenPercent"]?.int ?? 0)
                    
                    completion(comm: comm, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(comm: nil, successful: false)
                }
        }
    }

    
    func wsComm_Save(commIn: Comm, completion: (successful: Bool) -> Void) {
        // prms -> Parametrs
        let commParametrs: [String: AnyObject] = [
            "id": commIn.id
            ,"subjectCommID": commIn.subjectID
            ,"adminCommID": commIn.adminID
            ,"link": commIn.link]
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["comm": commParametrs]]
        
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/Comm_Save", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                
                switch response.result {
                case .Success(_):
                    
                    completion(successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                
                    completion(successful: false)
                }
        }
    }
    
    func wsComm_Del(commID: Int, completion: (successful: Bool) -> Void) {
        // prms -> Parametrs
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["id": commID]]
        
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/Comm_Del", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                
                switch response.result {
                case .Success(_):
                    completion(successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    
                    completion(successful: false)
                }
        }
    }
}