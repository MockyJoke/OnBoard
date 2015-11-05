//
//  User.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-04.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation

// A class represent a user
class User : NSObject{
    internal private(set) var Name : String
    internal private(set) var Id : String
    
    override init(){
        Name  = "NewUser"
        Id = NSUUID().UUIDString
    }
    
    init(name : String){
        Name  = name
        Id = NSUUID().UUIDString
    }
    
    
}
