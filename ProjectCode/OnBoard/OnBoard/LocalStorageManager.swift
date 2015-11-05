//
//  LocalStorageManager.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-04.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation

class LocalStorageManager : NSObject {
    // Singleton object for the manager
    internal private(set) static var sharedInstance = LocalStorageManager()
    private let defaults : NSUserDefaults
    
    private override init(){
        defaults = NSUserDefaults.standardUserDefaults()
    }
    
    // Saves a object into local storage
    func SaveObject (key : String, dataObject : NSObject){
        defaults.setValue(dataObject, forKey: key)
        defaults.synchronize()
    }
    
    // Loads a object from local storage
    func LoadObject (key : String) -> NSObject? {
        return defaults.stringForKey(key)
    }
}