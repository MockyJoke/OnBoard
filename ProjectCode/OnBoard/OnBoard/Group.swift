//
//  Group.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/21/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation


class Group : NSObject {
    
    var Id : Int
    var Name : String
    var GroupUsers =  [GroupUser]()
    init (json : JSON){
        Id = json["Id"].numberValue as Int
        Name = json["Name"].string!
        for (var i = 0 ; i < json["Users"].count ; i++){
            GroupUsers.append(GroupUser(json: json["Users"][i]))
        }
    }
}