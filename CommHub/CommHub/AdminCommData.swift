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
    
    func wsAdminComm_ReadDict(ownerHubID: Int, completion: (dirAdminsComm: [AdminComm], successful: Bool) -> Void) {
        // prms -> Parametrs
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["ownerHubID": ownerHubID]]
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
    
}