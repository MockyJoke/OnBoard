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
        CenterMapToUserLocation()
        //CenterMapToUserZoomed()
        
        
        LoadPinsFromStorage()
        
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
  
    func LoadPinsFromStorage(){
        //var key = GeoTagManager.sharedInstance.GetGeoTag(<#title: String#>)
        
        mapView.removeAnnotations(mapView.annotations)
     
        
        for (title, geoTag) in GeoTagManager.sharedInstance.geoTagDict{
            
            let annotation = MKPointAnnotation()
            annotation.title = geoTag.title
            annotation.subtitle = geoTag.subTitle
            annotation.coordinate = geoTag.GetCoordinate2D()
            
            self.mapView.addAnnotation(annotation)
        }
    }

    
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
  
    //Create Geo Tag Alert
    
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
            
            //self.inputedText1 = input1.text
            
            self.mapView.showsUserLocation = false
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = GPS
            if input1.text == ""{
                
                annotation.title = "Temporary Unnamed Location"
                
                self.mapView.removeAnnotation(annotation)
                
                self.mapView.showsUserLocation = true
            }
            else{
                annotation.title = input1.text
                annotation.subtitle = input2.text
                
                self.mapView.addAnnotation(annotation)
                
                self.mapView.showsUserLocation = true
                
                GeoTagManager.sharedInstance.SaveGeoTag(GeoTag(title: input1.text, description: input2.text, coord: annotation.coordinate))
                
                self.LoadPinsFromStorage()
            }
           
            
        }))
        
        alertcontroller.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            self.canceled = true
            
        }))
        self.presentViewController(alertcontroller, animated: true, completion: nil)
    }
    
    //Delete Annotation Alert
    
    func confirmDelete(pin: String) {
        let alert = UIAlertController(title: "Delete Geo-Tag", message: "Are you sure you want to permanently delete \(pin)?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: {(action) -> Void in
            
            //Delete Pin
            if let geoTag = GeoTagManager.sharedInstance.GetGeoTag(pin){
                    GeoTagManager.sharedInstance.DeleteGeoTag(geoTag)
            }
            self.LoadPinsFromStorage()
            return
        })

        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    //Draw Trail base on User's movement
    var lockedOn: Bool = false
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        //theLabel.text = "\(locations[0])"
        myLocations.append(locations[0] as! CLLocation)
        
        if lockedOn == true {
        let spanX = 0.007
        let spanY = 0.007
        var newRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
            mapView.setRegion(newRegion, animated: true)}
        
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
    
    //***Remove Annotation
    
   
    // When user taps on the disclosure button you can perform a segue to navigate to another view controller
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if control == view.rightCalloutAccessoryView{
            println(view.annotation.title) // annotation's title
            println(view.annotation.subtitle) // annotation's subttitle
            
            //Perform a segue here to navigate to another viewcontroller
            // On tapping the disclosure button you will get here
            confirmDelete(view.annotation.title!)
            
        }
    }
    
    // Here we add disclosure button inside annotation window
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        println("viewForannotation")
        if annotation is MKUserLocation {
            //return nil
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            //println("Pinview was nil")
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }
        
        var button = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton // button with info sign in it
        
        pinView?.rightCalloutAccessoryView = button
        
        
        return pinView
    }
    
    
    //***UI Buttons
    var segSelf = false
    var segGeo = false
    var segGroup = false
    
        @IBAction func tagCurrentLocationButton(sender: AnyObject) {
        showPinAlert(CLLocationCoordinate2D(latitude: self.mapView.userLocation.coordinate.latitude, longitude: self.mapView.userLocation.coordinate.longitude))
    }
    @IBOutlet weak var lockBarButton: UIBarButtonItem!
    
    @IBOutlet weak var lockButton: UIButton!
    var toggleState = 0
    @IBAction func lockOn(sender: AnyObject) {
        if toggleState == 0{
            lockButton.setImage(UIImage(named: "maplocked"), forState: UIControlState.Normal)
            self.lockedOn = true
            toggleState = 1
        }
        else{
            lockButton.setImage(UIImage(named: "mapunlocked"), forState: UIControlState.Normal)
            self.lockedOn = false
            toggleState = 0
        }
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
            mapView.showsUserLocation = true
        }
    }
    
    
    func CenterMapToUserZoomed(){
        let spanX = 0.007
        let spanY = 0.007
        if let location = CoreLocationManager.sharedInstance.latestLocation{
            var newRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
            mapView.setRegion(newRegion, animated: true)
        }
    }
    
    func CenterMapToResortLocation(){
        if let resort = SkiResortDataManager.sharedInstance.SelectedSkiResort {
            var regionRadius : CLLocationDistance = 5000
            mapView.setRegion(MKCoordinateRegionMakeWithDistance(resort.GetCoordinate2D(), regionRadius, regionRadius), animated: true)
        }
    }
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            //textLabel.text = "First selected";
            segSelf = true
        case 1:
            //textLabel.text = "Second Segment selected";
            
            segGeo = true
        default: 0
            break; 
        }     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
