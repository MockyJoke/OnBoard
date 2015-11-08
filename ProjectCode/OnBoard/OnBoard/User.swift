//
//  User.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-04.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation

// A class represent a user
class User : StorableObject{
    internal private(set) var Name : String
    internal private(set) var Id : String
    internal private(set) var EmergencyName : String
    internal private(set) var EmergencyPhone : String
    internal private(set) var SessionArray : [Session]?
    override init(){
        Name  = "NewUser"
        Id = NSUUID().UUIDString
        EmergencyName = ""
        EmergencyPhone = ""
        super.init()
    }
    
    init(name : String, emergencyName : String, emergencyPhone : String){
        Name  = name
        Id = NSUUID().UUIDString
        EmergencyPhone = emergencyPhone
        EmergencyName = emergencyName
        super.init()
    }
    
    required init(coder aDecoder:NSCoder){
        self.Name = User.decodeHelper(coder: aDecoder,propertyName: "Name",defaultVal: "")
        self.Id=User.decodeHelper(coder: aDecoder,propertyName: "Id",defaultVal: "")
        self.EmergencyName=User.decodeHelper(coder: aDecoder,propertyName: "EmergencyName",defaultVal: "")
        self.EmergencyPhone=User.decodeHelper(coder: aDecoder,propertyName: "EmergencyPhone",defaultVal: "")
        self.SessionArray=User.decodeHelper(coder: aDecoder,propertyName: "SessionArray",defaultVal: nil)
        super.init()
    }
    
    override func encodeWithCoder(aCoder:NSCoder){
        aCoder.encodeObject(Name,forKey:"Name")
        aCoder.encodeObject(Id,forKey:"Id")
        aCoder.encodeObject(EmergencyPhone,forKey:"EmergencyPhone")
        aCoder.encodeObject(EmergencyName,forKey:"EmergencyName")
        aCoder.encodeObject(SessionArray,forKey:"SessionArray")
    }
}



