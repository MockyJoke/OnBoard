//
//  UserManager.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-04.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation
import HealthKit

class UserManager : NSObject{
    let USERLIST_KEY = "USERLIST"
    let CURRENTUSERNAME_KEY = "CURRENTUSERNAME"
    internal private(set) static var sharedInstance = UserManager()
    internal private(set) var currentUser : User
    private var localUserDict : [String:User]

    private override init(){
        if let dict = LocalStorageManager.sharedInstance.LoadObject(USERLIST_KEY) as? [String:User]{
            localUserDict = dict
        }else{
            localUserDict = [String:User]()
            LocalStorageManager.sharedInstance.SaveObject(USERLIST_KEY, dataObject: localUserDict)
        }
        
        if let userName = LocalStorageManager.sharedInstance.LoadObject(CURRENTUSERNAME_KEY) as? String {
            if let user = localUserDict[userName]{
                currentUser = user
            }else{
                // User is gone!
                currentUser = User()
            }
        }else{
            currentUser = User()
        }
    }
    
    // Clear all the user info in local storage
    private func ResetUserList(){
        localUserDict = [String:User]()
        LocalStorageManager.sharedInstance.SaveObject(USERLIST_KEY, dataObject: localUserDict)
    }
    
    //Create a new User in the storage and returns the new User object
    internal func CreateNewUser(newName : String, emergeName : String , emergPhone : String, wght : HKQuantitySample?)-> User{
        var newUser = User(name: newName,emergencyName: emergeName ,emergencyPhone: emergPhone, weight: wght)
        localUserDict[newName] = newUser
        currentUser = newUser
        Save()
        return newUser
    }
    
    // Removes a user from the storage, retunrs if the deletion is successful
    internal func DeleteUserByName(name : String)->Bool{
        if let user = GetUserByName(name){
            localUserDict.removeValueForKey(user.Name)
            Save()
            return true
        }else{
            return false
        }
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
    
    internal func SpecifyCurrentUser(name: String) -> Bool {
        if let user = GetUserByName(name){
            currentUser = user
            Save()
            return true;
        }else{
            return false;
        }
    }
    
    internal func GetCurrentUser() -> User {
        return currentUser
    }
    
    internal func Save(){
        
        if (!currentUser.IsAnonymous){
            LocalStorageManager.sharedInstance.SaveObject(CURRENTUSERNAME_KEY, dataObject: currentUser.Name)
        }
        LocalStorageManager.sharedInstance.SaveObject(USERLIST_KEY, dataObject: localUserDict)
    }
    

}