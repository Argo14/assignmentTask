//
//  ConnectivityManager.swift
//  Assignment_task
//
//  Created by Arjun Gopakumar on 09/11/21.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
