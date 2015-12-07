//
//  Session.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/7/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation
import CoreLocation

class Session : StorableObject, NSCoding {
    internal private(set) var Resort : SkiResort?
    internal private(set) var StartTime : NSDate?
    internal private(set) var EndTime : NSDate?
    internal private(set) var IsStarted : Bool
    internal private(set) var IsEnded : Bool
    internal private(set) var SnapshotArray : [SessionSnapshot]
    internal private(set) var MaxSpeed : Double = 0
    init(resort : SkiResort){
        IsStarted = false
        IsEnded = false
        SnapshotArray = [SessionSnapshot]()
        Resort = resort
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        self.Resort = User.decodeHelper(coder: aDecoder,propertyName: "Resort",defaultVal: nil)
        self.StartTime=User.decodeHelper(coder: aDecoder,propertyName: "StartTime",defaultVal: NSDate())
        self.EndTime=User.decodeHelper(coder: aDecoder,propertyName: "EndTime",defaultVal: NSDate())
        self.IsStarted=User.decodeHelper(coder: aDecoder,propertyName: "IsStarted",defaultVal: false )
        self.IsEnded=User.decodeHelper(coder: aDecoder,propertyName: "IsEnded",defaultVal: false)
        self.SnapshotArray=User.decodeHelper(coder: aDecoder,propertyName: "SnapshotArray",defaultVal: [SessionSnapshot]())
        super.init()
    }
    
    override func encodeWithCoder(aCoder:NSCoder){
        aCoder.encodeObject(Resort,forKey:"Resort")
        aCoder.encodeObject(StartTime,forKey:"StartTime")
        aCoder.encodeObject(EndTime,forKey:"EndTime")
        aCoder.encodeObject(IsStarted,forKey:"IsStarted")
        aCoder.encodeObject(IsEnded,forKey:"IsEnded")
        aCoder.encodeObject(SnapshotArray,forKey:"SnapshotArray")
    }
    
    // To start this Session!
    func StartSession(){
        if ( !IsStarted && !IsEnded ){
            IsStarted = true
            StartTime = NSDate()
        }
    }
    
    // To end this session!
    func EndSession(){
        IsEnded = true;
        EndTime = NSDate();
    }
    
    // Get how many seconds since the session started
    func GetDuration() -> NSTimeInterval{
        if ( IsStarted && IsEnded ){
            return EndTime!.timeIntervalSinceDate(StartTime!)
        }else if(IsStarted && !IsEnded){
            return NSDate().timeIntervalSinceDate(StartTime!)
        }else{
            return 0;
        }
    }
    
    func GetDurationHMSString() -> String{
        let interval = Int(GetDuration())
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String (format: "%02d : %02d : %02d", hours, minutes, seconds)
    }
    
    func TakeSnapshot(){
        let snapshot = SessionSnapshot.GetCurrentSnapshot()
        SnapshotArray.append(snapshot)
    }
    
    // Returns distance travelled in meters
    func GetTotalDistance() -> CLLocationDistance {
        var totalDistance : CLLocationDistance = 0
        for var i = 0; i < SnapshotArray.count - 1; i++ {
            if let tempDist = SnapshotArray[i+1].locationSnapshot?.location.distanceFromLocation(SnapshotArray[i].locationSnapshot?.location) {
                totalDistance = totalDistance + tempDist
            }
        }
        return totalDistance
    }
    
    // Returns average speed in km/hr
    func GetAvgSpeed() -> Double {
        let distance = self.GetTotalDistance()
        let time = Double(self.GetDuration())
        let distance_km = distance / 1000
        let time_hours = time / 3600
        return distance_km / time_hours
    }
}