//
//  Session.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/7/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation

class Session : NSObject{
    internal private(set) var StartTime : NSDate?
    internal private(set) var EndTime : NSDate?
    internal private(set) var IsStarted : Bool
    internal private(set) var IsEnded : Bool
    
    override init(){
        IsStarted = false
        IsEnded = false
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
    
    func RecordSnapShot(){
        
    }
}