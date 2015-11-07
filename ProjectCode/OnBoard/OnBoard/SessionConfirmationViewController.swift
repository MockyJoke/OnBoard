//
//  SessionConfirmationViewController.swift
//  OnBoard
//
//  Created by Rainbow Riders on 15/11/4.
//  Copyright © 2015 Rainbow Riders. All rights reserved.
//

import UIKit
import MapKit

class SessionConfirmationViewController: UIViewController {

    var selectedResort : SkiResort?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Session Confirmation"
        
        var regionRadius : CLLocationDistance = 10000
        if let resort = selectedResort {
            mapView.setRegion(MKCoordinateRegionMakeWithDistance(resort.GetCoordinate2D(), regionRadius, regionRadius), animated: true)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
