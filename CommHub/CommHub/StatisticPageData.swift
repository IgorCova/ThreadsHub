//
//  StatisticPageData.swift
//  CommHub
//
//  Created by Andrew Dzhur on 24/05/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class StatisticPageData {
    
    func wsStaCommVKGraph_Report(commID: Int, completion: (dirVkGraph: [VkGraph], successful: Bool) -> Void) {
        let  prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ["commID":commID]]
        
        
        Alamofire.request(.POST, "\(HubService)/StaCommVKGraph_Report", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].arrayValue
                    var dirVkGraph: [VkGraph] = []
                    
                    for info in json {
                        let vkGraph = VkGraph(
                             likes: info["likes"].intValue
                            ,comments: info["comments"].intValue
                            ,share: info["share"].intValue
                            ,removed: info["removed"].intValue
                            ,members: info["members"].intValue
                            ,membersLost: info["membersLost"].intValue
                            ,dayString: info["dayString"].stringValue
                            ,isLast: info["isLast"].boolValue
                            ,isFuture: info["isFuture"].boolValue)
                        
                        dirVkGraph.append(vkGraph)
                    }
                    
                    completion(dirVkGraph: dirVkGraph, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(dirVkGraph: [], successful: false)
                }
        }
    }
}