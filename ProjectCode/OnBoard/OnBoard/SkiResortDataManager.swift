//
//  SkiResortDataManager.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-05.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation
import CoreLocation

class SkiResortDataManager : NSObject {
    // Singleton object for the manager
    internal private(set) static var sharedInstance = SkiResortDataManager()
    
    internal private(set) var SkiResortArray : [SkiResort]
    
    private override init(){
        SkiResortArray = [SkiResort]()
        let path = NSBundle.mainBundle().pathForResource("SkiResortData", ofType: "plist") //parse SkiAreaData.plist
        let dict = NSDictionary(contentsOfFile: path!)!
        var index = 0
        for (key,value) in dict{
            SkiResortArray.append(SkiResort(lineString: value as! String))
            index++
        }
    }
    
    static func GetDistanceBetweenLocations(location : CLLocation , otherLocation : CLLocation) -> Double{
        return location.distanceFromLocation(otherLocation)
    }
}