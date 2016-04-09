//
//  SessionData.swift
//  Threads
//
//  Created by Igor Cova on 13/02/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

class SessionData {

    func wsSessionReqSave(phone: String, completion : (reqres: SessionReqRes, successful: Bool) -> Void) {
        let prms : [String : AnyObject] = ["Session": "MySessionID", "DID": MyDID, "Params": ["Phone": phone]]
           print (prms)
        Alamofire.request(.POST, "\(HubService)/SessionReq_Save", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionary
                    let regRes = SessionReqRes(id: json!["id"]!.int!, code: json!["code"]!.string!, ownerHubID: json!["ownerHubID"]!.int!)
                    
                    completion(reqres: regRes, successful: true)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    let regRes = SessionReqRes(id: 0, code: "", ownerHubID: 0)
                    completion(reqres: regRes, successful: false)
                }
        }
    }

    func wsSessionSave(sessionReqId: Int, completion : (own: OwnerHubEntryFields, isNew: Bool, successful: Bool) -> Void) {
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["SessionReq_ID": sessionReqId]]
        // print (prms)
        Alamofire.request(.POST, "\(HubService)/Session_Save", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionary
                    let own = OwnerHubEntryFields(id: json!["ownerHubID"]!.int!, sessionId: json!["SessionID"]!.string!)
                    let isNewMember = json!["IsNewMember"]!.bool!
                    completion(own: own, isNew: isNewMember, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    let own = OwnerHubEntryFields(id: 0, sessionId: "")
                    completion(own: own,  isNew: false, successful: false)
                }
        }
    }
    
}
