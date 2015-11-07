//
//  CMMotionManager.swift
//  OnBoard
//
//  Created by George Cui on 11/6/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation
import CoreMotion
class MotionManager : NSObject {
    
    internal private(set) static var sharedInstance = MotionManager()
    
    private var motionManager = CMMotionManager()
    //internal private(set) var motionArray : [velocityPerSecond]

    //internal private(set) var speedArray: [distancePerSecond]

    
    private override init(){
        motionManager.accelerometerUpdateInterval = 1
    }
}

