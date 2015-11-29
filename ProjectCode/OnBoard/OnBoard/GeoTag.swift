//
//  GeoTag.swift
//  OnBoard
//
//  Created by George Cui on 11/29/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation

class GeoTag : StorableObject, NSCoding{
    
    var title : String
    var subTitle : String
    var lat : Double
    var lon : Double
    
    init(title : String , description : String , lat : Double , lon : Double){
        self.title = title
        self.subTitle = description
        self.lat = lat
        self.lon = lon
        super.init()
    }
    
    init (title : String , description : String , coord : CLLocationCoordinate2D){
        self.title = title
        self.subTitle = description
        self.lat = coord.latitude
        self.lon = coord.longitude
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.title = GeoTag.decodeHelper(coder: aDecoder,propertyName: "title",defaultVal: "")
        self.subTitle=GeoTag.decodeHelper(coder: aDecoder,propertyName: "subTitle",defaultVal: "")
        self.lat=GeoTag.decodeHelper(coder: aDecoder,propertyName: "lat",defaultVal: 0)
        self.lon=GeoTag.decodeHelper(coder: aDecoder,propertyName: "lon",defaultVal: 0 )
        super.init()
    }
    
    override func encodeWithCoder(aCoder:NSCoder){
        aCoder.encodeObject(title,forKey:"title")
        aCoder.encodeObject(subTitle,forKey:"subTitle")
        aCoder.encodeObject(lat,forKey:"lat")
        aCoder.encodeObject(lon,forKey:"lon")
    }
    
    func GetCoordinate2D() -> CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
}