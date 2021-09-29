//
//  CandidateModelClass.swift
//  Assignment_task
//
//  Created by Arjun Gopakumar on 27/09/21.
//

import Foundation


struct Candidates : Codable{
    let data : [CandidateData]
    
}

//MARK:- Candidate data

public struct CandidateData : Codable{
    let firstName, lastName, gender, profileImage : String?
    let age : Int?
    let jobData : [JobData]
    let educationData : [EducationData]
    
    enum CodingKeys : String, CodingKey{
        case firstName = "firstname"
        case lastName = "lastname"
        case age = "age"
        case gender = "gender"
        case profileImage = "picture"
        case jobData = "job"
        case educationData = "education"
    }
}

//MARK:- Job
struct JobData : Codable{
    let role, organization : String
    let exp : Int?
    
    enum CodingKeys : String, CodingKey{
        case role = "role"
        case organization = "organization"
        case exp = "exp"
    }
}

//MARK:- education
struct EducationData : Codable{
    let degree, institution : String
    
    enum CodingKeys : String, CodingKey{
        case degree = "degree"
        case institution = "institution"
    }
}

//MARK:- For candidate sections
public struct canidateSections {
    var title : String
    var items : [CandidateData]
    var collapsed : Bool
    public init(title : String, items : [CandidateData], collapsed : Bool = true){
        self.title = title
        self.items = items
        self.collapsed = collapsed
    }
}
//MARK:- For job and education sections
    public struct jobSections{
        var title : String
        var items : [JobData]
        var collapsed : Bool
         init(title : String, items : [JobData], collapsed : Bool = true){
            self.title = title
            self.items = items
            self.collapsed = collapsed
        }
    }



