//
//  AFWrapper.swift
//  
//
//  Created by Arjun Gopakumar on 19/07/21.
//


import UIKit

import Alamofire

class AFWrapper: NSObject {
    
// API to get the candidate list.
    class func requestGETNew(methodName:String,success:@escaping (Candidates) -> Void, failure:@escaping (Error) -> Void) {
        
        print(APPURL.BaseURL + methodName )
        
        AF.request(URL(string:APPURL.BaseURL + methodName )!, method: .get, encoding: URLEncoding.default)
           
            .responseDecodable(of: Candidates.self) { (responseObject) in
                
                print(responseObject)
            
                switch responseObject.result{
                case.success(_):

                    let resJson = responseObject.value
                    success(resJson!)
                    break
                case.failure(let error):
                    let error : Error = error
                    if(error.localizedDescription == "The Internet connection appears to be offline."){
                        Common.showAlert(title: "Network error", message: error.localizedDescription)
                    }else{
                        Common.showAlert(title: "No Internet", message: "Unable to connect to the server, the internet connection appears to be offline")
                    }
                    failure(error)
                    break
                }
                
                
            }
        }

}
