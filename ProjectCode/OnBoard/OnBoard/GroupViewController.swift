//
//  GroupViewController.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-27.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit
import MapKit
class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate{
    var group : Group?
    var updateTimer : NSTimer?
    
    @IBOutlet weak var helpSignalSwitch: UISwitch!
    @IBOutlet weak var groupMapView: MKMapView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var memberTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup group update timer 
        update()
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(25, target: self, selector: "update", userInfo: nil, repeats: true)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func update(){
        Report()
        UpdateGroup()
        memberTableView.reloadData()
    }
    

    func UpdateGroup(){
        if(OnlineServiceManager.sharedInstance.CreateUserOnServer(UserManager.sharedInstance.currentUser)){
            if let group = OnlineServiceManager.sharedInstance.FindGroupById(UserManager.sharedInstance.currentUser.GroupId!){
                self.group = group
                groupNameLabel.text = group.Name
            }
            
        }
    }
    
    func Report(){
        let user = UserManager.sharedInstance.currentUser
        if (user.IsAnonymous) {
            return
        }
        
        if let location = CoreLocationManager.sharedInstance.latestLocation{
            OnlineServiceManager.sharedInstance.SaveActiveData(user.Id, lat: location.coordinate.latitude, lon: location.coordinate.longitude, isAbnormal: helpSignalSwitch.on)
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
    
   // MARK : - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let g = group {
           return g.GroupUsers.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = memberTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! GroupTableViewCell
        if let g = group {
            cell.UpdateCell(g.GroupUsers[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if let cell = memberTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? GroupTableViewCell{
            cell.TapAction()
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            if let g = group {
                cell.UpdateCell(g.GroupUsers[indexPath.row])
                showGroupUserOnMap(g.GroupUsers[indexPath.row])
            }
        }
    }
    
    /********** MAPPING *****************/
    func mapView(mapView: MKMapView!,
        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            
            if annotation is MKUserLocation {
                //return nil so map view draws "blue dot" for standard user location
                return nil
            }
            
            let reuseId = "pin"
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.animatesDrop = true
            }
            else {
                pinView!.annotation = annotation
            }
            //pinView!.image = UIImage(named:"User_red")!
            
            return pinView
    }
    
    func showGroupUserOnMap(groupUser : GroupUser){
        groupMapView.removeAnnotations(groupMapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.title = groupUser.Name
        annotation.coordinate = groupUser.GetLocation()!.coordinate
            
        groupMapView.addAnnotation(annotation)
        CenterMapOnCoordinate(annotation.coordinate);
    }
    
    func CenterMapOnCoordinate (coordinate : CLLocationCoordinate2D){
        let spanX = 0.007
        let spanY = 0.007
        var newRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        groupMapView.setRegion(newRegion, animated: true)
    }
    @IBAction func helpSignalSwitchAction(sender: AnyObject) {
        update()
    }
    

}
