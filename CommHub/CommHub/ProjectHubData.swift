//
//  ProjectData.swift
//  CommHub
//
//  Created by Andrew Dzhur on 30/07/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class ProjectHubData {
    
    func wsProjectHub_ReadDict(completion: ( dirProjects: [Project], successful: Bool) -> Void) {
        // prms -> Parametrs
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID]
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/ProjectHub_ReadDict", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    var projects = [Project]()
                    for sc in json {
                        let project = Project(id: sc["id"].int!, name: sc["name"].string!)
                        
                        projects.append(project)
                    }
                    
                    
                    
                    completion(dirProjects: projects, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(dirProjects: [Project](), successful: false)
                }
        }
    }
    
    func wsProjectHub_Save(project: Project, completion: (successful: Bool) -> Void) {
        // prms -> Parametrs
        let projectParametrs: [String: AnyObject] = [
            "id": project.id
            ,"name": project.name]
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["project" : projectParametrs]]
        
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/ProjectHub_Save", parameters: prms, encoding: .JSON)
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
    
    func wsProjectHub_Del(projectID: Int, completion: (successful: Bool) -> Void) {
        // prms -> Parametrs
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["id": projectID]]
        
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/ProjectHub_Del", parameters: prms, encoding: .JSON)
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