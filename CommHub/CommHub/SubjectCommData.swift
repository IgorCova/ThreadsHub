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
    
    func wsSubjectComm_ReadDict(completion: (dirSubjectComm: [SubjectComm], successful: Bool) -> Void) {
        // prms -> Parametrs
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID]
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
    
    func wsSubjectComm_Save(subject: SubjectComm, completion: (subjectOut: SubjectComm?, successful: Bool) -> Void) {
        // prms -> Parametrs
        let subjectParametrs: [String: AnyObject] = [
             "id": subject.id
            ,"name": subject.name]
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": subjectParametrs]
        
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/SubjectComm_Save", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                
                switch response.result {
                case .Success(let data):
                    let su = JSON(data)["Data"].dictionary!
                    
                    let subjectComm = SubjectComm(
                         id: su["id"]!.int ?? 0
                        ,name: su["name"]!.stringValue)
                    
                    completion(subjectOut: subjectComm, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    
                    completion(subjectOut: nil, successful: false)
                }
        }
    }
    
    func wsSubjectComm_Del(subjectID: Int, completion: (successful: Bool) -> Void) {
        // prms -> Parametrs
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["id": subjectID]]
        
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/SubjectComm_Del", parameters: prms, encoding: .JSON)
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