//
//  APPURL.swift
//  
//
//  Created by Arjun Gopakumar on 05/12/18.
//
//

import Foundation
struct APPURL {
    
    private struct Domains {
        static let Live     = "https://bbf2a516-7989-4779-a5bf-ecb2777960c4.mock.pstmn.io/v1/prod/"
        static let Dev      = "https://bbf2a516-7989-4779-a5bf-ecb2777960c4.mock.pstmn.io/v1/dev/"
    }
    
    private  struct Routes {
        static let Api = "t2/employee/"
    }
    
    private  static let Domain  = Domains.Dev
    private  static let Route   = Routes.Api
   
    
    
    static let BaseURL = Domain + Route
  
    
    static let AuthorizationToken = ""
}

