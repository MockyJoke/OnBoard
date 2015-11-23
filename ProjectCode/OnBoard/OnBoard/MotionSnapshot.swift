//
//  MotionSnapshot.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/7/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//
//
//import Foundation
//import CoreMotion
//
//class MotionSnapshot: StorableObject, NSCoding{
//    var accleration : CMAcceleration
//    
//    init(acceleration : CMAcceleration) {
//        self.accleration = acceleration
//        super.init()
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        self.accleration = MotionSnapshot.decodeHelper(coder: aDecoder,propertyName: "acceleration",defaultVal: CMAcceleration())
//        super.init()
//    }
//        override func encodeWithCoder(aCoder:NSCoder){
//            aCoder.encodeObject(accleration ,forKey:"acceleration")
//        }
// 
//        
//}