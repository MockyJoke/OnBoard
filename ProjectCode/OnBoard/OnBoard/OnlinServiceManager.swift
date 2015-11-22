//
//  OnlinServiceManager.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/21/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation



class OnlineServiceManager : NSObject{
    // Singleton object for the manager
    internal private(set) static var sharedInstance = OnlineServiceManager()
    
    private override init(){
        
    }
    
    func CreateUserOnServer(user : User) {
        let url = "http://OnBoardWeb.cloudapp.net/api/users?name="+user.Name
        var json = WebApiManager.sharedInstance.MakeHTTPRequestSync(url,methond: "PUT")
        
    }  
}