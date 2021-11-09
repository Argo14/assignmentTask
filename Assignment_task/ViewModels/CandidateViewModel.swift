//
//  CandidateViewModel.swift
//  Assignment_task
//
//  Created by Arjun Gopakumar on 27/09/21.
//

import UIKit
import Foundation

protocol StopRefreshDelegate{
    func stopRefresh(_ errorResponse : String)
}

protocol BackOnlineDelegate{
    func backOnline()
}


class CandidateViewModel: NSObject {
    
    var bindCandidateViewModelToController : (() -> ()) = {}
    var tempDict : [CandidateData] = []
    var data : [canidateSections] = []
    var moreTempDict : [JobData] = []
    var moreData : [jobSections] = []
    var delegate : StopRefreshDelegate!
    var onlineDelegate : BackOnlineDelegate!
    var candidateData : Candidates!
    var candidateSections : [canidateSections]!{
        didSet {
            // binding with viewcontrtoller when the candidate section is set from the api.
            self.bindCandidateViewModelToController()
        }
    }
    
    override init() {
        super.init()
        getCandidateData()
    }
    
    // Api call.
    // Save data to files in success.
    //Retrieve data from files, incase there is no internet.
    // Converting the data recieved from the api to candidate sections for creating the datasource with title and items associated for each title.
    func getCandidateData(){
        
        AFWrapper.requestGETNew(methodName: "getAllDetails", success: { (response) in
            self.candidateData = response
            for items in  response.data{
                self.tempDict.append(CandidateData(firstName: items.firstName, lastName: items.lastName, gender: items.gender, profileImage: items.profileImage, age: items.age, jobData: items.jobData, educationData: items.educationData))
                
                let firstName = items.firstName ?? ""
                let lastName = items.lastName ?? ""
                
                self.data.append(canidateSections(title: firstName + " " + lastName,items : self.tempDict))
                self.tempDict.removeAll()
                
            }
            self.candidateSections = self.data
            
            
            self.onlineDelegate.backOnline()
            do{
                _ = try SaveFile.save(response, for: "candidates")
            }catch{
                #if DEBUG
                print("not saved")
                #endif
            
            }
            
        }, failure: {(response) in
            do{
                let dataFile = try SaveFile.loadJSON(withFilename: "candidates")
                for items in dataFile!.data{
                    self.tempDict.append(CandidateData(firstName: items.firstName, lastName: items.lastName, gender: items.gender, profileImage: items.profileImage, age: items.age, jobData: items.jobData, educationData: items.educationData))
                    
                    let firstName = items.firstName ?? ""
                    let lastName = items.lastName ?? ""
                    
                    self.data.append(canidateSections(title: firstName + " " + lastName,items : self.tempDict))
                    self.tempDict.removeAll()
                    
                }
                self.candidateSections = self.data
                self.delegate.stopRefresh(response.localizedDescription)
            }catch{
                
            }
            
        })
    }
    
    // function called to set the datasource for the job and experience section of each items.
     func getData( moredata : CandidateData) -> [jobSections] {
    
        self.moreData.removeAll()
        for items in moredata.jobData{
            self.moreTempDict.append(JobData(role: items.role, organization: items.organization, exp: items.exp))
        }
        self.moreData.append(jobSections(title: "Experience", items: self.moreTempDict))
        self.moreTempDict.removeAll()
        
        for items in moredata.educationData{
            self.moreTempDict.append(JobData(role: items.degree, organization: items.institution, exp: 0))
        }
        self.moreData.append(jobSections(title: "Education", items: self.moreTempDict))
        self.moreTempDict.removeAll()
         return self.moreData
    }
}
