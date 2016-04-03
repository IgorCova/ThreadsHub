//
//  SubjectData.swift
//  CommHub
//
//  Created by Andrew Dzhur on 03/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation

class SubjectData {
    
    func getSubjects() -> [Subject] {
        var subjectArr = [Subject]()
        
        subjectArr.append(Subject(id: 1, subjectName: "Sport"))
        subjectArr.append(Subject(id: 2, subjectName: "Art"))
        subjectArr.append(Subject(id: 3, subjectName: "Entertiment"))
        subjectArr.append(Subject(id: 4, subjectName: "Car"))
        subjectArr.append(Subject(id: 5, subjectName: "Plain"))
        subjectArr.append(Subject(id: 6, subjectName: "Gazon"))
            
        return subjectArr
    }
}