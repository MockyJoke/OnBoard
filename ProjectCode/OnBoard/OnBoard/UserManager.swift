//
//  UserManager.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-04.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation

class UserManager : NSObject{
    let USERLIST_KEY = "USERLIST"
    internal private(set) static var sharedInstance = UserManager()
    internal private(set) var currentUser : User?
    private var localUserDict : [String:User]

    private override init(){
        if let dict = LocalStorageManager.sharedInstance.LoadObject(USERLIST_KEY) as? [String:User]{
            localUserDict = dict
        }else{
            localUserDict = [String:User]()
            LocalStorageManager.sharedInstance.SaveObject(USERLIST_KEY, dataObject: localUserDict)
        }
    }
    
    // Clear all the user info in local storage
    private func ResetUserList(){
        localUserDict = [String:User]()
        LocalStorageManager.sharedInstance.SaveObject(USERLIST_KEY, dataObject: localUserDict)
    }
    
    //Create a new User in the storage and returns the new User object
    internal func CreateNewUser(newName : String, emergeName : String , emergPhone : String)-> User{
        var newUser = User(name: newName,emergencyName: emergeName ,emergencyPhone: emergPhone)
        localUserDict[newName] = newUser
        Save()
        return newUser
    }
    
    internal func GetUserByName(name: String) -> User?{
        return localUserDict[name] as User?
    }
    
    internal func GetUserCount() -> Int {
        return localUserDict.count
    }
    
    internal func GetUserArray()->Array<User>{
        return Array(localUserDict.values)
    }
    
    private func Save(){
        LocalStorageManager.sharedInstance.SaveObject(USERLIST_KEY, dataObject: localUserDict)
    }
    
}