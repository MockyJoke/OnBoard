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
    
    private override init(){
        motionManager.accelerometerUpdateInterval = 0.01
    }
    
    func StartUpdate(){
        motionManager.startAccelerometerUpdates()
    }
    
    func StopUpdate(){
        motionManager.stopAccelerometerUpdates()
    }
    
    func GetCurrentAcceleration() -> CMAcceleration{
        let rand = Double(arc4random()%100 - 50)
        return CMAcceleration(x: rand,y: 1,z: 1)
        //return motionManager.accelerometerData.acceleration
    }
}

