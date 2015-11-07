//
//  SessionSnapshot.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/7/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//
//
import Foundation

struct SessionSnapshot{
    var locationSnapshot : LocationSnapshot?
    var motionSnapshot : MotionSnapshot?
    init (){
        if(CoreLocationManager.sharedInstance.IsLocationAvail){
            locationSnapshot = LocationSnapshot(location: CoreLocationManager.sharedInstance.latestLocation!)
        }
        MotionManager.sharedInstance.GetCurrentAcceleration()
    }
    
    static func GetCurrentSnapshot(){
        var newSnapshot = SessionSnapshot()
        if(CoreLocationManager.sharedInstance.IsLocationAvail){
            newSnapshot.locationSnapshot = LocationSnapshot(location: CoreLocationManager.sharedInstance.latestLocation!)
        }
        newSnapshot.motionSnapshot = MotionSnapshot(accleration: MotionManager.sharedInstance.GetCurrentAcceleration())
    }
}