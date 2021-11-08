//
//  Assignment_taskTests.swift
//  Assignment_taskTests
//
//  Created by Arjun Gopakumar on 27/09/21.
//

import XCTest
@testable import Assignment_task

class Assignment_taskTests: XCTestCase {
    var viewController : ViewController = ViewController()
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
            self.bindCandidateViewModelToController()
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCandidateAPI() throws{
        
       
        
        let testApi = expectation(description: "Got the data sucessfully")
   
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
            
            
           // self.onlineDelegate.backOnline()
            testApi.fulfill()
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
               XCTFail("Should not enter this block")
               // self.delegate.stopRefresh(response.localizedDescription)
            }catch{
               
            }
            
        })
        wait(for: [testApi], timeout: 10)
    }
    
    func testCandidateAPIWithoutConnection() throws{
     
        let testApi = expectation(description: "Saved to file")
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
            
            XCTFail("Should not enter success")
           // self.onlineDelegate.backOnline()
          
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
                testApi.fulfill()
               // self.delegate.stopRefresh(response.localizedDescription)
            }catch{
                XCTFail("Data not retrieved")
            }
            
        })
        wait(for: [testApi], timeout: 10)
    }
    
    

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
