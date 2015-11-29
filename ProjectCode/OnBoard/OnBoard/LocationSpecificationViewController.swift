//
//  LocationSpecificationViewController.swift
//  OnBoard
//
//  Created by Rainbow Riders on 15/11/4.
//  Copyright © 2015 Rainbow Riders. All rights reserved.
//

import UIKit
import CoreLocation
import Darwin

class LocationSpecificationViewController: UIViewController,UITableViewDelegate{

    @IBOutlet weak var nearestButton: UIView!
    @IBOutlet weak var chooseLocation: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func pickClosestResort(sender: AnyObject) {
        if let userLocation = CoreLocationManager.sharedInstance.latestLocation {
            var index = SkiResortDataManager.sharedInstance.GetClosestResortIndex(userLocation)
            var path = NSIndexPath (forRow : index, inSection : 0)
            tableView.selectRowAtIndexPath(path, animated: true, scrollPosition: UITableViewScrollPosition.None)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let location = CoreLocationManager.sharedInstance.latestLocation {
            println("Lat: \(location.coordinate.latitude), Long: \(location.coordinate.longitude)")
        }
        
        //addBlurEffectToView(photoView)
        
        // Do any additional setup after loading the view.
        self.chooseLocation.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func addBlurEffectToView(targetView : UIView){
        var effect = UIBlurEffect (style: UIBlurEffectStyle.Light)
        var effectView = UIVisualEffectView(effect: effect)
        effectView.layer.cornerRadius = 10.0
        effectView.clipsToBounds = true
        effectView.frame = CGRectMake (0,0,targetView.frame.width*0.9,targetView.frame.height * 0.9)
        targetView.addSubview(effectView)
    }*/
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SkiResortDataManager.sharedInstance.SkiResortArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        var userArray = UserManager.sharedInstance.GetUserArray()
        cell.textLabel?.text =  SkiResortDataManager.sharedInstance.SkiResortArray[indexPath.row].Name
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Ski Resorts"
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let backLabel = UIBarButtonItem()
        backLabel.title = "Back"
        navigationItem.backBarButtonItem = backLabel
        
        var sessionConfirmationVC = segue.destinationViewController as! SessionConfirmationViewController
        sessionConfirmationVC.selectedResort = nil
        if let pathIndex = tableView.indexPathForSelectedRow() {
            sessionConfirmationVC.selectedResort = SkiResortDataManager.sharedInstance.SkiResortArray[pathIndex.row]
            SkiResortDataManager.sharedInstance.SetSelectedResort(SkiResortDataManager.sharedInstance.SkiResortArray[pathIndex.row])
        }else{
            sessionConfirmationVC.selectedResort = SkiResortDataManager.sharedInstance.SkiResortArray[0]
            SkiResortDataManager.sharedInstance.SetSelectedResort(SkiResortDataManager.sharedInstance.SkiResortArray[0])
        }
    }
    

}
