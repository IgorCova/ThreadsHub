//
//  MemberData.swift
//  Threads
//
//  Created by Igor Cova on 30/01/16.
//  Copyright © 2016 Igor Cova. All rights reserved.
//
import Foundation
import CoreData
import Alamofire
import SwiftyJSON

class OwnerHubData {
    
    func wsOwnerHub_Read(completion: (owner : OwnerHub?, successful: Bool) -> Void) {
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID]
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/OwnerHub_Read", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                //print(response.result.value)
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)["Data"].dictionaryValue
                    let own = OwnerHub(
                             id:        json["id"]!.int ?? 0
                            ,firstName: json["firstName"]!.stringValue
                            ,lastName:  json["lastName"]!.stringValue
                            ,phone:     json["phone"]!.stringValue
                            ,linkFB:    json["linkFB"]!.stringValue
                    )
                    
                    completion(owner: own, successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(owner: nil , successful: false)
                }
        }
    }
    
    func wsOwnerHub_Save(own: OwnerHub, completion: (successful: Bool) -> Void) {
        // prms -> Parametrs
        let ownParametrs: [String: AnyObject] = [
             "firstName": own.firstName
            ,"lastName": own.lastName ?? ""
            ,"phone": own.phone
            ,"linkFB": own.linkFB ?? ""]
        
        let prms : [String : AnyObject] = ["Session": MySessionID, "DID": MyDID, "Params": ownParametrs]
        
        print (prms)
        
        Alamofire.request(.POST, "\(HubService)/OwnerHub_Save", parameters: prms, encoding: .JSON)
            .responseJSON { response in
                print(response.result.value)
                switch response.result {
                case .Success( _):
                    completion(successful: true)
                case .Failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completion(successful: false)
                }
        }
    }

    func getLogInfo() -> (Int, String) {

        var myOwnerHubID: Int = 0
        var mySessionID: String = ""
        
        let appDelegate: AppDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Log")

        do {
            let fetchResult = try context.executeFetchRequest(fetchRequest) as! [Log]
            print(fetchResult)
            if !fetchResult.isEmpty {
                myOwnerHubID = (fetchResult[0].ownerHubID as! Int)
                mySessionID = (fetchResult[0].sessionID! as String)
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return (myOwnerHubID, mySessionID)
    }

    func deleteLog() {
        let appDelegate: AppDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Log")

        do {
            let fetchResult = try context.executeFetchRequest(fetchRequest) as! [Log]
            for element in fetchResult {
                context.deleteObject(element as NSManagedObject)
            }
            try context.save()
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func saveOwnerHubEntry (member: OwnerHubEntryFields) {
        let appDelegate: AppDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        let newMember = NSEntityDescription.insertNewObjectForEntityForName("Log", inManagedObjectContext: context) as! Log
        print("Начало сохранения")
        newMember.ownerHubID = member.id
        newMember.sessionID = member.sessionId
        
        do {
            //rself.deleteLog()
            try context.save()
            print("Успешно")
        } catch {
            print("Неуспешно")
        }
    }

    
}