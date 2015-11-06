//
//  CoreLocationManager.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-04.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation
import CoreLocation

// A manager class helps reading data from the device's GPS sensor
class CoreLocationManager: NSObject , CLLocationManagerDelegate{
    // Singleton object for the manager
    internal private(set) static var sharedInstance = CoreLocationManager()

    private var locationManager : CLLocationManager = CLLocationManager()

    // Stores the most up to date location
    internal private(set) var latestLocation : CLLocation?
    var authStatus : CLAuthorizationStatus?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.authStatus = CLAuthorizationStatus.NotDetermined
    }
    
    func StartUpdate(){
        locationManager.startUpdatingLocation()
    }
    func StopUpdate(){
        locationManager.stopUpdatingLocation()
    }
    
    // Update location authorization status
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        authStatus = status
    }
    
    // A new location is updated
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        latestLocation = locations.last as! CLLocation?
    }
}
