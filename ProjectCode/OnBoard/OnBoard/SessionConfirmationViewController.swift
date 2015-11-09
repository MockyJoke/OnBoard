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
    
    @IBOutlet weak var beginASButton: UIButton!
    @IBOutlet weak var toggleButtonAreaView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!

    
    

    @IBAction func toggleMapType(sender: AnyObject) {
        if let toggle = sender as? UISwitch{
            mapView.mapType = toggle.on ? MKMapType.Hybrid : MKMapType.Standard
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedResort!.Name
        self.beginASButton.layer.cornerRadius = 10
        if let resort = selectedResort {
            self.telLabel.text = resort.Phone
            self.siteLabel.text = resort.Website
            self.seasonLabel.text = resort.Season
        }
        
        mapView.mapType = MKMapType.Standard
        var regionRadius : CLLocationDistance = 5000
        if let resort = selectedResort {
            mapView.setRegion(MKCoordinateRegionMakeWithDistance(resort.GetCoordinate2D(), regionRadius, regionRadius), animated: true)
        }
        addBlurEffectToView(toggleButtonAreaView)
        // Do any additional setup after loading the view.
        
        
    }
    func addBlurEffectToView(targetView : UIView){
        var effect = UIBlurEffect (style: UIBlurEffectStyle.Light)
        var effectView = UIVisualEffectView(effect: effect)
        effectView.frame = CGRectMake (0,0,targetView.frame.width,targetView.frame.height)
        targetView.insertSubview(effectView, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell = UITableViewCell()
//        if let resort = selectedResort {
//            switch indexPath.row {
//            case 0:
//                cell.textLabel?.text = resort.Address
//            case 1:
//                cell.textLabel?.text = resort.Phone
//            case 2:
//                cell.textLabel?.text = resort.Website
//            case 3:
//                cell.textLabel?.text = resort.Season
//            default:
//                cell.textLabel?.text = resort.Name
//            }
//        }
//        return cell
//    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let resort = selectedResort{
            var newSession = SessionManager.sharedInstance.CreateNewCurrentSession(resort)
            UserManager.sharedInstance.GetCurrentUser().AddNewSession(newSession)
            newSession.StartSession()
        }
    }
    

}
