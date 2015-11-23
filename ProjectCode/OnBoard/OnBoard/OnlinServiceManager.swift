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
    
    func CreateUserOnServer(user : User) -> Bool{
        let url = "http://OnBoardWeb.cloudapp.net/api/users?name="+user.Name
        if let json = WebApiManager.sharedInstance.MakeHTTPRequestSync(url,methond: "PUT"){
            user.UpdateWithJSON(json)
            return true
        }else{
            return false
        }
    }
    
    func FindGroupById(groupId : Int) -> Group? {
        let url = "http://OnBoardWeb.cloudapp.net/api/groups/\(groupId)"
        if let json = WebApiManager.sharedInstance.MakeHTTPRequestSync(url,methond: "GET"){
            return Group(json: json)
        }else{
            return nil
        }
    }
    
    func JoinGroup(user : User, groupId : Int) -> Group? {
        let url = "http://OnBoardWeb.cloudapp.net/api/users/\(user.Id)?groupId=\(groupId)"
        if let json = WebApiManager.sharedInstance.MakeHTTPRequestSync(url,methond: "POST"){
            return Group(json: json)
        }else{
            return nil
        }
    }
    
    func CreateGroup(name : String) -> Group? {
        let url = "http://OnBoardWeb.cloudapp.net/api/groups?name=\(name)"
        if let json = WebApiManager.sharedInstance.MakeHTTPRequestSync(url,methond: "PUT"){
            return Group(json: json)
        }else{
            return nil
        }
    }
}