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
    var Data : ActiveData?
    init(json : JSON){
        Id = json["Id"].numberValue as Int
        Name = json["Name"].string!
        Data = ActiveData(json : json["ActiveData"])
    }
    func IsYourself()-> Bool{
        return Id == UserManager.sharedInstance.currentUser.Id
    }
    
    func IsAbnormal() -> Bool{
        if let data = Data{
            if (data.StatusCode == "1"){
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    func GetLocation()-> CLLocation? {
        if let data = Data{
            return CLLocation(latitude: data.Lat, longitude: data.Lon)
        }else{
            return nil
        }
    }
    
    func GetDistanceToOtherUser(groupUser : GroupUser) -> Double{
        if let data = Data{
            if let otherData = groupUser.Data{
                return GetLocation()!.distanceFromLocation(groupUser.GetLocation()!)
            }
            return 0
        }else{
            return 0
        }
    }
    
    func GetDistanceToCoordinate(coordinate : CLLocation) -> Double{
        if let data = Data{
            return GetLocation()!.distanceFromLocation(coordinate)
        }else{
            return 0
        }
    }
}