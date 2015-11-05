//
//  LocalStorageManager.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-04.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation


// A manager class provides basic fucntionality to read/write device's
// local storage.
class LocalStorageManager : NSObject {
    // Singleton object for the manager
    internal private(set) static var sharedInstance = LocalStorageManager()
    private let defaults : NSUserDefaults
    
    private override init(){
        defaults = NSUserDefaults.standardUserDefaults()
    }
    
    // Saves a object into local storage
    func SaveObject (key : String, dataObject : AnyObject){
        defaults.setValue(dataObject, forKey: key)
        defaults.synchronize()
    }
    
    // Loads a object from local storage
    func LoadObject (key : String) -> AnyObject? {
        return defaults.objectForKey(key)
    }
    
    // Checks if a key exist
    func IsKeyExist(key: String)-> Bool{
        return defaults.objectForKey(key) == nil
    }
}