//
//  SkiResort.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-05.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation
import CoreLocation

class SkiResort : StorableObject, NSCoding {
    internal private(set) var Name : String?
    internal private(set) var Id : String?
    internal private(set) var Season : String?
    internal private(set) var Phone : String?
    internal private(set) var Lat : Double
    internal private(set) var Lon : Double
    internal private(set) var Website : String?
    internal private(set) var Address : String?
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
        super.init()
    }
    
    func GetDistanceFrom(otherLocation : CLLocation) -> Double{
        var resortLocation = CLLocation(latitude: Lat,longitude: Lon)
        return resortLocation.distanceFromLocation(otherLocation)
    }
    
    func GetCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Lat, longitude: Lon)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.Name = SkiResort.decodeHelper(coder: aDecoder, propertyName: "Name", defaultVal: nil)
        self.Id = SkiResort.decodeHelper(coder: aDecoder, propertyName: "Id", defaultVal: nil)
        self.Season = SkiResort.decodeHelper(coder: aDecoder, propertyName: "Season", defaultVal: nil)
        self.Phone = SkiResort.decodeHelper(coder: aDecoder, propertyName: "Phone", defaultVal: nil)
        self.Lat = SkiResort.decodeHelper(coder: aDecoder, propertyName: "Lat", defaultVal: 0.0)
        self.Lon = SkiResort.decodeHelper(coder: aDecoder, propertyName: "Lon", defaultVal: 0.0)
        self.Website = SkiResort.decodeHelper(coder: aDecoder, propertyName: "Website", defaultVal: nil)
        self.Address = SkiResort.decodeHelper(coder: aDecoder, propertyName: "Address", defaultVal: nil)
        super.init()
    }
    
    override func encodeWithCoder(aCoder:NSCoder){
        aCoder.encodeObject(Name, forKey:"Name")
        aCoder.encodeObject(Id, forKey:"Id")
        aCoder.encodeObject(Season, forKey:"Season")
        aCoder.encodeObject(Phone, forKey:"Phone")
        aCoder.encodeObject(Lat, forKey:"Lat")
        aCoder.encodeObject(Lon, forKey:"Lon")
        aCoder.encodeObject(Website, forKey:"Website")
        aCoder.encodeObject(Address, forKey:"Address")
    }
}