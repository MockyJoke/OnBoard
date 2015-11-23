//
//  MapViewController.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/9/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tagCurrentLocationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CenterMapToResortLocation()
        
        mapView.showsUserLocation = true
    
        
    }
    

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
    
    var inputedText1: String = "Place"
    var inputedText2: String = "Short Description"
    var canceled: Bool!

    
    @IBAction func addPin(sender: UILongPressGestureRecognizer) {
        
        sender.minimumPressDuration = 2.0
        mapView.showsUserLocation = false
        showPinAlert()
        
        let location = sender.locationInView(self.mapView)
        let coordinates = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = coordinates
        
        annotation.title = inputedText1+"HIT"
        annotation.subtitle = inputedText2
        
        self.mapView.addAnnotation(annotation)
        
        mapView.showsUserLocation = true
        
        
        //self.mapView.removeAnnotation(<#annotation: MKAnnotation!#>)
        
    }
    
    
    
  
    func showPinAlert() {
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
            self.inputedText1 = input1.text
            
            println(input1.text+"HIHIHI")
        
        }))
            
        alertcontroller.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
        self.canceled = true
    
        }))
            self.presentViewController(alertcontroller, animated: true, completion: nil)
    }

    
    
    @IBAction func tagCurrentLocationButton(sender: AnyObject) {
        showPinAlert()
        let annotation = MKPointAnnotation()
        annotation.title = "Place"
        
        annotation.subtitle = "Short Description"
        annotation.coordinate = CLLocationCoordinate2D(latitude: self.mapView.userLocation.coordinate.latitude, longitude: self.mapView.userLocation.coordinate.longitude)
        self.mapView.addAnnotation(annotation)
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
