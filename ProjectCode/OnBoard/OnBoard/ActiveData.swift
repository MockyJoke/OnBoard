//
//  ActiveData.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-27.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation

class ActiveData : NSObject{
    var Lat : Double
    var Lon : Double
    //var User : GroupUser
    var Id : Int
    var StatusCode : String
    init(json : JSON){
        Id = json["Id"].numberValue as Int
        Lat = json["Lat"].numberValue as Double
        Lon = json["Lon"].numberValue as Double
        StatusCode = json["StatusCode"].stringValue
        //User = GroupUser(json: json["User"])
    }
}