//
//  Admin\Data.swift
//  CommHub
//
//  Created by Andrew Dzhur on 03/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AdminCommData {
    
    func wsAdminComm_ReadDict(completion: (dirAdminsComm: [AdminComm], successful: Bool) -> Void) {
        // prms -> Parametrs
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID]
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/AdminComm_ReadDict", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    var adminsComm = [AdminComm]()
                    for ad in json {
                        let adminComm = AdminComm(
                            id: ad["id"].int!
                           ,firstName: ad["firstName"].string!
                           ,lastName: ad["lastName"].string!
                           ,phone: ad["phone"].string!
                           ,linkFB: ad["linkFB"].string!)
                        
                        adminsComm.append(adminComm)
                    }
                    
                    completion(dirAdminsComm: adminsComm, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(dirAdminsComm: [AdminComm](), successful: false)
                }
        }
    }
    
    func wsAdminComm_Save(admin: AdminComm, completion: (adminOut: AdminComm?, successful: Bool) -> Void) {
        // prms -> Parametrs
        let adminParametrs: [String: AnyObject] = [
            "id": admin.id
            ,"firstName": admin.firstName
            ,"lastName": admin.lastName
            ,"phone": admin.phone
            ,"linkFB": admin.linkFB ?? ""]
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": adminParametrs]
        
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/AdminComm_Save", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                
                switch response.result {
                case .Success(let data):
                    let ad = JSON(data)["Data"].dictionaryValue
                    
                        let adminComm = AdminComm(
                            id: ad["id"]!.int ?? 0
                            ,firstName: ad["firstName"]!.stringValue
                            ,lastName: ad["lastName"]!.stringValue
                            ,phone: ad["phone"]!.stringValue
                            ,linkFB: ad["linkFB"]!.stringValue)
                    
                    completion(adminOut: adminComm, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    
                    completion(adminOut: nil, successful: false)
                }
        }
    }
    
    func wsAdminComm_Del(adminID: Int, completion: (successful: Bool) -> Void) {
        // prms -> Parametrs
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["id": adminID]]
        
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/AdminComm_Del", parameters: prms, encoding: .JSON)
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