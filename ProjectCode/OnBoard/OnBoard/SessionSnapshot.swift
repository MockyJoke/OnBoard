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
    var snapshotTime : NSDate
    var locationSnapshot : LocationSnapshot?
    var motionSnapshot : MotionSnapshot
    init (){
        snapshotTime = NSDate()
        if(CoreLocationManager.sharedInstance.IsLocationAvail){
            locationSnapshot = LocationSnapshot(location: CoreLocationManager.sharedInstance.latestLocation!)
        }
        motionSnapshot = MotionSnapshot (accleration: MotionManager.sharedInstance.GetCurrentAcceleration())
    }
    
    
    // Creates a new Snapshot
    static func GetCurrentSnapshot()-> SessionSnapshot{
        var newSnapshot = SessionSnapshot()
        if(CoreLocationManager.sharedInstance.IsLocationAvail){
            newSnapshot.locationSnapshot = LocationSnapshot(location: CoreLocationManager.sharedInstance.latestLocation!)
        }
        newSnapshot.motionSnapshot = MotionSnapshot(accleration: MotionManager.sharedInstance.GetCurrentAcceleration())
        return newSnapshot
    }
}