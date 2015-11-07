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
    var CurrentSession : Session?
    
}