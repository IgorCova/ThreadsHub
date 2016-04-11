//
//  SubjectData.swift
//  CommHub
//
//  Created by Andrew Dzhur on 03/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class SubjectCommData {
    
    func wsSubjectComm_ReadDict(ownerHubID: Int, completion: (dirSubjectComm: [SubjectComm], successful: Bool) -> Void) {
        // prms -> Parametrs
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["ownerHubID": ownerHubID]]
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/SubjectComm_ReadDict", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    var subjectsComm = [SubjectComm]()
                    for sc in json {
                        let subject = SubjectComm(id: sc["id"].int!, name: sc["name"].string!)
                        
                            subjectsComm.append(subject)
                    }

                    completion(dirSubjectComm: subjectsComm, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(dirSubjectComm: [SubjectComm](), successful: false)
                }
        }
    }
}