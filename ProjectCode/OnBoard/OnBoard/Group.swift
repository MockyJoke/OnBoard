//
//  Group.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/21/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation


class Group : NSObject {
    
    var Id : String
    var Name : String
    init (json : JSON){
        Id = json["Id"].string!
        Name = json["Name"].string!
    }
    
}