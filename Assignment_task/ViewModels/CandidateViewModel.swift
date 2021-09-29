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
    
    var tempDict : [CandidateData] = []
    var canidateData : Candidates!{
        didSet {
            self.bindCandidateViewModelToController()
        }
    }
    var delegate : StopRefreshDelegate!
    var onlineDelegate : BackOnlineDelegate!
    
    var bindCandidateViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        getCandidateData()
    }
    
    func getCandidateData(){
        
        AFWrapper.requestGETNew(methodName: "getAllDetails", success: { (response) in
            self.canidateData = response
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
                self.canidateData = try SaveFile.loadJSON(withFilename: "candidates")
                self.delegate.stopRefresh(response.localizedDescription)
            }catch{
                
            }
            
        })
    }
    
}
