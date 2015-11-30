//
//  MapViewController.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/9/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tagCurrentLocationButton: UIButton!
    
    var manager:CLLocationManager!
    var myLocations: [CLLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //  print("connectivity is \(Connectivity.isConnectedToNetwork())")
        
        
        //check if there is an internet connection
        Connectivity.checkConnection()
        
        
        // Do any additional setup after loading the view.
        CenterMapToResortLocation()
        
        //LoadPinsFromStorage()
        
        //Setup our Location Manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        //Setup our Map View
        mapView.delegate = self
        //mapView.mapType = MKMapType.Satellite
        mapView.showsUserLocation = true
    }
  
    /*func LoadPinsFromStorage(){
        //var key = GeoTagManager.sharedInstance.GetGeoTag(<#title: String#>)
        for (title, geoTag) in GeoTagManager.sharedInstance.geoTagDict{
            
            let annotation = MKPointAnnotation()
            annotation.title = geoTag.title
            annotation.subtitle = geoTag.subTitle
            annotation.coordinate = geoTag.GetCoordinate2D()
            
            self.mapView.addAnnotation(annotation)
        }
    }
    */

    /*Following Variables for Pin Dropping & Alert feature
    var inputedText1: UITextField?
    var inputedText2: UITextField?
    
    var canceled: Bool
    
    End of Pin Dropping & Alert Variables
    */
    /* Zoom in on User, missing "resort" coordinates
    func centerOnUser(){
        var regionRadius : CLLocationDistance = 500
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(resort.GetCoordinate2D(), regionRadius, regionRadius), animated: true)
    }*/
    
    var location = CGPoint()
    var coordinates = CLLocationCoordinate2D()
    var inputedText1: String = "Place"
    var inputedText2: String = "Description"
    var canceled: Bool!

    
    @IBAction func addPin(sender: UILongPressGestureRecognizer) {
        
        sender.minimumPressDuration = 2.0
        
        location = sender.locationInView(self.mapView)
        coordinates = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)
        
        showPinAlert(coordinates)
        
        //self.mapView.removeAnnotation(<#annotation: MKAnnotation!#>)

    }
  
    
    func showPinAlert(GPS: CLLocationCoordinate2D) {
        var alertcontroller = UIAlertController(title: "Create Geo-Tag?", message: "Save this location on your Maps", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        alertcontroller.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Name this location"
            
            //textField.secureTextEntry = true
            
        })
        
        alertcontroller.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Describe this location"
            
            //textField.secureTextEntry = true
            
        })
        
        alertcontroller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            let input1 = alertcontroller.textFields?.first as! UITextField
            
            let input2 = alertcontroller.textFields?[1] as! UITextField
            
            self.inputedText1 = input1.text
            
            self.mapView.showsUserLocation = false
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = GPS
            
            annotation.title = input1.text
            annotation.subtitle = input2.text
           
            self.mapView.addAnnotation(annotation)
            
            self.mapView.showsUserLocation = true
            
            GeoTagManager.sharedInstance.SaveGeoTag(GeoTag(title: input1.text, description: input2.text, coord: annotation.coordinate))
            
            
        }))
        
        alertcontroller.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            self.canceled = true
            
        }))
        self.presentViewController(alertcontroller, animated: true, completion: nil)
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        //theLabel.text = "\(locations[0])"
        myLocations.append(locations[0] as! CLLocation)
        
        let spanX = 0.007
        let spanY = 0.007
        var newRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        mapView.setRegion(newRegion, animated: true)
        
        if (myLocations.count > 1){
            
            var sourceIndex = myLocations.count - 1
            var destinationIndex = myLocations.count - 2
            
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[destinationIndex].coordinate
            var a = [c1, c2]
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            mapView.addOverlay(polyline)
            
            
            }
        }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.4)
            polylineRenderer.lineWidth = 8
            return polylineRenderer
        }
        else {
            return nil
        }
    }
    
    //Remove Annotation
    
    /*@IBAction func removePin(sender: UITapGestureRecognizer) {
        sender.numberOfTapsRequired = 2
        
        if sender.locationInView(self.mapView) = MKPointAnnotation().coordinate{
            
            
        }
        
        
        
    }*/
    
    
    /*var tap = UITapGestureRecognizer(target: self, action: removeAnnotation())
    tap.numberOfTapsRequired = 1
    self.mapView.addGestureRecognizer(tap)
    
    func removeAnnotation(gesture: UIGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            self.mapView.removeAnnotation(annotation)
            println("Annotation Removed")
            
        }
        
    }*/
    
    
    @IBAction func tagCurrentLocationButton(sender: AnyObject) {
        showPinAlert(CLLocationCoordinate2D(latitude: self.mapView.userLocation.coordinate.latitude, longitude: self.mapView.userLocation.coordinate.longitude))
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userLocationButtonAction(sender: AnyObject) {
        CenterMapToUserLocation()
    }
    
    func CenterMapToUserLocation(){
        if let location = CoreLocationManager.sharedInstance.latestLocation{
            var regionRadius : CLLocationDistance = 1000
            mapView.setRegion(MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius), animated: true)
        }
    }
    
    func CenterMapToResortLocation(){
        if let resort = SkiResortDataManager.sharedInstance.SelectedSkiResort {
            var regionRadius : CLLocationDistance = 5000
            mapView.setRegion(MKCoordinateRegionMakeWithDistance(resort.GetCoordinate2D(), regionRadius, regionRadius), animated: true)
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
