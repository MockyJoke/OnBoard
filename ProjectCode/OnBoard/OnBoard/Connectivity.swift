//
//  Connectivity.swift
//  OnBoard
//
//  Created by Rajdeep Kaur on 11/22/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
    
class Connectivity {
   
    static func connectedToNetwork() -> Bool {
            
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
                SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
            }
            
            var flags: SCNetworkReachabilityFlags = 0
            if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
                return false
            }
            
            let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            
            return isReachable && !needsConnection
        }
    
    
    // function to show pop up when there is no interenet connection
    static func checkConnection(){
        if Connectivity.connectedToNetwork() == true {
            println("Internet Connection works good")
        } else {
            println("Internet connection FAILED")
            var alert = UIAlertView(title: "No Internet Connection", message: "Check if your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
    }
 
    
}



