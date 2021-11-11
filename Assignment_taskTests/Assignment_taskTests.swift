//
//  Assignment_taskTests.swift
//  Assignment_taskTests
//
//  Created by Arjun Gopakumar on 27/09/21.
//

import XCTest
import Alamofire
@testable import Assignment_task

class Assignment_taskTests: XCTestCase {
    var viewController : ViewController = ViewController()
    var dataSaved : Bool!
    
    
     override func setUp() {
        super.setUp()
        
      
        
    
    }
    
    func testCandidateAPI() throws{
        try XCTSkipUnless(
            Connectivity.isConnectedToInternet == true,
          "Network connectivity needed for this test.")

       
        
        let testApi = expectation(description: "Got the data sucessfully")
   
        AFWrapper.requestGETNew(methodName: "getAllDetails", success: { (response) in
     
            testApi.fulfill()
            do{
                _ = try SaveFile.save(response, for: "candidates")
                let fileManager = FileManager.default
                let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
                if let url = urls.first {
                    var fileURL = url.appendingPathComponent("candidates")
                    fileURL = fileURL.appendingPathExtension("json")
                    
                    guard fileManager.fileExists(atPath: fileURL.path) else{
                        return self.dataSaved = false
                    }
                    
                    self.dataSaved = true
                }
                
                
                
                
            }catch{
                #if DEBUG
                print("not saved")
                #endif
            
            }
            
        }, failure: {(response) in
           
            do{
                let dataFile = try SaveFile.loadJSON(withFilename: "candidates")
               
              
               XCTFail("Should not enter this block")
               // self.delegate.stopRefresh(response.localizedDescription)
            }catch{
               
            }
            
        })
        wait(for: [testApi], timeout: 10)
        XCTAssertEqual(true, dataSaved)
        
    }
    
    func testCandidateAPIWithoutConnection() throws{
        try XCTSkipUnless(
            Connectivity.isConnectedToInternet == false,
          "Network connectivity is not needed for this test.")

        let testApi = expectation(description: "Saved to file")
        AFWrapper.requestGETNew(methodName: "getAllDetails", success: { (response) in
        
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
              
               
                testApi.fulfill()
               // self.delegate.stopRefresh(response.localizedDescription)
            }catch{
                XCTFail("Data not retrieved")
            }
            
        })
        wait(for: [testApi], timeout: 10)
    }
    
    

}
