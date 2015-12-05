//
//  GeoTagManager.swift
//  OnBoard
//
//  Created by George Cui on 11/29/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation


class GeoTagManager : NSObject{
    // Singleton object for the manager
    private let GEOTAGDICT_KEY = "GEOTAGDICT_KEY"
    internal private(set) static var sharedInstance = GeoTagManager()
    var geoTagDict : [String : GeoTag]
    private override init(){
        
        if let dict = LocalStorageManager.sharedInstance.LoadObject(GEOTAGDICT_KEY) as? [String : GeoTag]{
            geoTagDict = dict
        }
        
        else{
            geoTagDict = [String : GeoTag]()
            LocalStorageManager.sharedInstance.SaveObject(GEOTAGDICT_KEY, dataObject: geoTagDict)
        }
    }
    
    func  SaveGeoTag(geoTag : GeoTag ){
        geoTagDict[geoTag.title] = geoTag
        Save()
    }
    
    func GetGeoTag(title : String) -> GeoTag?{
        return geoTagDict[title];
    }
    
    func DeleteGeoTag(geoTag: GeoTag){
        geoTagDict.removeValueForKey(geoTag.title)
        
        Save()
        }
    
    private func Save(){
        LocalStorageManager.sharedInstance.SaveObject(GEOTAGDICT_KEY, dataObject: geoTagDict)
    }
    
}