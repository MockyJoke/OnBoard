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
    internal private(set) var EmergencyName : String
    internal private(set) var EmergencyPhone : String
    
    override init(){
        Name  = "NewUser"
        Id = NSUUID().UUIDString
        EmergencyName = ""
        EmergencyPhone = ""
    }
    
    init(name : String, emergencyName : String, emergencyPhone : String){
        Name  = name
        Id = NSUUID().UUIDString
        EmergencyPhone = emergencyPhone
        EmergencyName = emergencyName
    }
    
    init(coder aDecoder:NSCoder!){
        self.Name=aDecoder.decodeObjectForKey("Name") as! String
        self.Id=aDecoder.decodeObjectForKey("Id") as! String
        self.EmergencyName=aDecoder.decodeObjectForKey("EmergencyName") as! String
        self.EmergencyPhone=aDecoder.decodeObjectForKey("EmergencyPhone") as! String
    }
    
    func encodeWithCoder(aCoder:NSCoder!){
        aCoder.encodeObject(Name,forKey:"Name")
        aCoder.encodeObject(Id,forKey:"Id")
        aCoder.encodeObject(EmergencyPhone,forKey:"EmergencyPhone")
        aCoder.encodeObject(EmergencyName,forKey:"EmergencyName")
    }
}
