//
//  GroupUser.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/22/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation


class GroupUser : NSObject{
    var Id : Int
    var Name : String
    init(json : JSON){
        Id = json["Id"].numberValue as Int
        Name = json["Name"].string!
    }
}