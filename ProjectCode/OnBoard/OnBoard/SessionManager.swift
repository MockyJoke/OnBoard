//
//  SessionManager.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/7/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation


class SessionManager : NSObject{
    // Singleton object for the manager
    internal private(set) static var sharedInstance = SessionManager()
    internal private(set) var CurrentSession : Session?
    
    private override init(){
        
    }
    
    func CreateNewCurrentSession( skiResort : SkiResort) -> Session{
        var newSession = Session(resort: skiResort)
        //user.SessionArray?.append()
        CurrentSession = newSession
        return newSession
    }
    
    func StartCurrentSession(){
        if let session = CurrentSession{
            session.StartSession()
        }
    }
    
    func EndCurrentSession(){
        if let session = CurrentSession{
            session.EndSession()
        }
    }
    
}