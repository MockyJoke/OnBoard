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
    internal private(set) var Id : Int
    internal private(set) var EmergencyName : String
    internal private(set) var EmergencyPhone : String
    internal  var SessionArray : [Session]?
    internal private(set) var IsAnonymous : Bool
    override init(){
        Name  = "Anonymous"
        Id = 0
        EmergencyName = ""
        EmergencyPhone = ""
        IsAnonymous = true;
        super.init()
    }
    
    init(name : String, emergencyName : String, emergencyPhone : String){
        Name  = name
        Id = 0
        EmergencyPhone = emergencyPhone
        EmergencyName = emergencyName
        IsAnonymous = false
        super.init()
    }
    
    required init(coder aDecoder:NSCoder){
        self.Name = User.decodeHelper(coder: aDecoder,propertyName: "Name",defaultVal: "")
        self.Id=User.decodeHelper(coder: aDecoder,propertyName: "Id",defaultVal: 0)
        self.EmergencyName=User.decodeHelper(coder: aDecoder,propertyName: "EmergencyName",defaultVal: "")
        self.EmergencyPhone=User.decodeHelper(coder: aDecoder,propertyName: "EmergencyPhone",defaultVal: "")
        let sessionArrayData = User.decodeHelper(coder: aDecoder,propertyName: "SessionArray",defaultVal: NSData())
        self.SessionArray = NSKeyedUnarchiver.unarchiveObjectWithData(sessionArrayData) as? [Session]
        
        self.IsAnonymous=User.decodeHelper(coder: aDecoder,propertyName: "IsAnonymous",defaultVal: false)
        super.init()
    }
    
    override func encodeWithCoder(aCoder:NSCoder){
        aCoder.encodeObject(Name,forKey:"Name")
        aCoder.encodeObject(Id,forKey:"Id")
        aCoder.encodeObject(EmergencyPhone,forKey:"EmergencyPhone")
        aCoder.encodeObject(EmergencyName,forKey:"EmergencyName")
        println("SessionBeing Saved, count: \(SessionArray?.count)")
        //aCoder.encodeObject(SessionArray,forKey:"SessionArray")
        if let sessionArray  = SessionArray{
            aCoder.encodeObject(sessionArray.ToNSData(sessionArray),forKey:"SessionArray")
        }
        aCoder.encodeObject(IsAnonymous,forKey:"IsAnonymous")
    }
    
    internal func AddNewSession(session : Session){
        if(SessionArray == nil){
            SessionArray = [Session]()
        }
        SessionArray!.append(session)
    }
    
    func UpdateWithJSON(json : JSON ){
        Id = json["Id"].numberValue as Int
    }
}



