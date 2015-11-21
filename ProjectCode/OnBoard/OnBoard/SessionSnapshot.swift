//
//  SessionSnapshot.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/7/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//
//
import Foundation

class SessionSnapshot : StorableObject, NSCoding{
    var snapshotTime : NSDate
    var locationSnapshot : LocationSnapshot?
    //var motionSnapshot : MotionSnapshot?
    override init (){
        snapshotTime = NSDate()
        if(CoreLocationManager.sharedInstance.IsLocationAvail){
            locationSnapshot = LocationSnapshot(location: CoreLocationManager.sharedInstance.latestLocation!)
        }
      //  motionSnapshot = MotionSnapshot (accleration: MotionManager.sharedInstance.GetCurrentAcceleration())
        super.init()
        
    }
    
    
    // Creates a new Snapshot
    static func GetCurrentSnapshot()-> SessionSnapshot{
        var newSnapshot = SessionSnapshot()
        if(CoreLocationManager.sharedInstance.IsLocationAvail){
            newSnapshot.locationSnapshot = LocationSnapshot(location: CoreLocationManager.sharedInstance.latestLocation!)
        }
      //  newSnapshot.motionSnapshot = MotionSnapshot(accleration: MotionManager.sharedInstance.GetCurrentAcceleration())
        return newSnapshot
    }
    
    required init(coder aDecoder: NSCoder) {
        self.snapshotTime = SessionSnapshot.decodeHelper(coder: aDecoder,propertyName: "snapshotTime",defaultVal: NSDate())
        self.locationSnapshot = SessionSnapshot.decodeHelper(coder: aDecoder, propertyName: "locationSnapshot", defaultVal: nil )
        //self.motionSnapshot = SessionSnapshot.decodeHelper(coder: aDecoder, propertyName: "motionSnapshot", defaultVal: nil )
        super.init()
    }
    
    override func encodeWithCoder(aCoder:NSCoder){
        aCoder.encodeObject(snapshotTime,forKey:"snapshotTime")
        aCoder.encodeObject(locationSnapshot,forKey:"locationSnapshot")
        //aCoder.encodeObject(motionSnapshot,forKey:"motionSnapshot")
    
            }
}