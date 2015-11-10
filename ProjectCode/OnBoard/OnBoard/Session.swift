//
//  Session.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/7/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation

class Session : StorableObject{
    internal private(set) var Resort : SkiResort?
    internal private(set) var StartTime : NSDate?
    internal private(set) var EndTime : NSDate?
    internal private(set) var IsStarted : Bool
    internal private(set) var IsEnded : Bool
    internal private(set) var SnapshotArray : [SessionSnapshot]

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
        self.IsEnded=User.decodeHelper(coder: aDecoder,propertyName: "SessionArray",defaultVal: false)
        self.SnapshotArray=User.decodeHelper(coder: aDecoder,propertyName: "SnapshotArray",defaultVal: [SessionSnapshot]())
        super.init()
    }
    
    override func encodeWithCoder(aCoder:NSCoder){
        //aCoder.encodeObject(Resort,forKey:"Resort")
        aCoder.encodeObject(StartTime,forKey:"StartTime")
        aCoder.encodeObject(EndTime,forKey:"EndTime")
        aCoder.encodeObject(IsStarted,forKey:"IsStarted")
        aCoder.encodeObject(IsEnded,forKey:"IsEnded")
        //aCoder.encodeObject(SnapshotArray,forKey:"SessionSnapshot")
    }
    
    // To start this Session!
    func StartSession(){
        if ( !IsStarted && !IsEnded){
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
        if ( IsStarted && IsEnded){
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
    
    func RecordSnapShot(){
        SnapshotArray.append(SessionSnapshot.GetCurrentSnapshot())
    }
}