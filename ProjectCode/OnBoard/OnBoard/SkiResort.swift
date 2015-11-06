//
//  SkiResort.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-05.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation
import CoreLocation

struct SkiResort{
    internal private(set) var Name : String
    internal private(set) var Id : String
    internal private(set) var Season : String
    internal private(set) var Phone : String
    internal private(set) var Lat : Double
    internal private(set) var Lon : Double
    internal private(set) var Website : String
    internal private(set) var Address : String
    init (lineString : String){
        var sectionArray = split(lineString) {$0 == "@"}
        Id = sectionArray[0]
        Name = sectionArray[1]
        Season = sectionArray[2]
        Phone = sectionArray[3]
        Lat = (sectionArray[4] as NSString).doubleValue
        Lon = (sectionArray[5] as NSString).doubleValue
        Website = sectionArray[6]
        Address = sectionArray[7]
    }
    
    func GetDistanceFrom(otherLocation : CLLocation) -> Double{
        var resortLocation = CLLocation(latitude: Lat,longitude: Lon)
        return resortLocation.distanceFromLocation(otherLocation)
    }
}