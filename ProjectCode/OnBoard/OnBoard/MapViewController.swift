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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CenterMapToResortLocation()
        
        mapView.showsUserLocation = true
    
        
    }
    
    
    
    /* Zoom in on User, missing "resort" coordinates
    func centerOnUser(){
        var regionRadius : CLLocationDistance = 500
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(resort.GetCoordinate2D(), regionRadius, regionRadius), animated: true)
    }*/
    

    
    @IBAction func addPin(sender: UILongPressGestureRecognizer) {
        
        sender.minimumPressDuration = 2.0
        
        showPinAlert()
        
        let location = sender.locationInView(self.mapView)
        let coordinates = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = coordinates
        
        annotation.title = "Place"
        annotation.subtitle = "Short Description"
        
        self.mapView.addAnnotation(annotation)
        
        //self.mapView.removeAnnotation(<#annotation: MKAnnotation!#>)
        
    }
    
    func showPinAlert() {
        var alert = UIAlertController(title: "Create Geo-Tag?", message: "Save this location on your Maps", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        var name = alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Name this location"
            //textField.secureTextEntry = true
        })
            
        var description = alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Describe this location"
            //textField.secureTextEntry = true
            
        })
            self.presentViewController(alert, animated: true, completion: nil)
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
