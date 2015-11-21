//
//  LocationSnapshot.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/7/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation
import CoreLocation

class LocationSnapshot : StorableObject, NSCoding{
    var location : CLLocation
    
    init(location :CLLocation) {
        self.location = location
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
         self.location = LocationSnapshot.decodeHelper(coder: aDecoder,propertyName: "location",defaultVal: CLLocation())
        super.init()
    }
    
    override func encodeWithCoder(aCoder:NSCoder){
        aCoder.encodeObject(location,forKey:"location")
    }
}