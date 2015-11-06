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
        self.Name = User.decodeHelper(coder: aDecoder,propertyName: "Name",defaultVal: "")
        self.Id=User.decodeHelper(coder: aDecoder,propertyName: "Id",defaultVal: "")
        self.EmergencyName=User.decodeHelper(coder: aDecoder,propertyName: "EmergencyName",defaultVal: "")
        self.EmergencyPhone=User.decodeHelper(coder: aDecoder,propertyName: "EmergencyPhone",defaultVal: "")
    }
    
    static func decodeHelper<T>(coder aDecoder:NSCoder!, propertyName : String, defaultVal: T) -> T{
        var result : T
        if let obj = aDecoder.decodeObjectForKey(propertyName) as? T {
            result = obj
        }else{
            result = defaultVal
        }
        return result
    }
    
    func encodeWithCoder(aCoder:NSCoder!){
        aCoder.encodeObject(Name,forKey:"Name")
        aCoder.encodeObject(Id,forKey:"Id")
        aCoder.encodeObject(EmergencyPhone,forKey:"EmergencyPhone")
        aCoder.encodeObject(EmergencyName,forKey:"EmergencyName")
    }
}
