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
    //func getCommunity() -> [Community] {
    //    let adminArr = [Community]()
    //
    //
    //    return adminArr
    //}
    
    func wsComm_ReadDict(ownerHubID: Int, completion: (dirComm: [Comm], successful: Bool) -> Void) {
        // prms -> Parametrs
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["ownerHubID": ownerHubID]]
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
                            firstName: co["adminCommID_firstName"].stringValue
                           ,lastName: co["adminCommID_lastName"].stringValue
                           ,linkFB: co["adminCommID_linkFB"].stringValue)
                        
                        let communityComm = Comm(id: co["id"].int!, name: co["name"].stringValue, subject: subjectComm, admin: adminComm, link: co["link"].stringValue)
                        
                        communitiesComm.append(communityComm)
                    }
                    
                    completion(dirComm: communitiesComm, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(dirComm: [Comm](), successful: false)
                }
        }
    }
}