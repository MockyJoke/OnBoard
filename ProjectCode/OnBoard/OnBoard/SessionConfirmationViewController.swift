//
//  SessionConfirmationViewController.swift
//  OnBoard
//
//  Created by Rainbow Riders on 15/11/4.
//  Copyright © 2015 Rainbow Riders. All rights reserved.
//

import UIKit
import MapKit

class SessionConfirmationViewController: UIViewController,UITableViewDelegate {

    var selectedResort : SkiResort?
    
    @IBOutlet weak var infoTable: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedResort!.Name
        
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
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let resort = selectedResort {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = resort.Address
            case 1:
                cell.textLabel?.text = resort.Phone
            case 2:
                cell.textLabel?.text = resort.Website
            case 3:
                cell.textLabel?.text = resort.Season
            default:
                cell.textLabel?.text = resort.Name
            }
        }
        return cell
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
