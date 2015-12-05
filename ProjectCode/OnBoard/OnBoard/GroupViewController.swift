//
//  GroupViewController.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-27.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var group : Group?
    var updateTimer : NSTimer?
    @IBOutlet weak var memberTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup group update timer 
        update()
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "update", userInfo: nil, repeats: true)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update(){
        UpdateGroup()
        memberTableView.reloadData()
        Report()
    }
    
    func Report(){
        let user = UserManager.sharedInstance.currentUser
        if (user.IsAnonymous) {
            return
        }
        if let location = CoreLocationManager.sharedInstance.latestLocation{
            OnlineServiceManager.sharedInstance.SaveActiveData(user.Id, lat: location.coordinate.latitude, lon: location.coordinate.longitude, statusCode: "0")
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
            }
        }
    }
    
    
    func UpdateGroup(){
        if(OnlineServiceManager.sharedInstance.CreateUserOnServer(UserManager.sharedInstance.currentUser)){
            if let group = OnlineServiceManager.sharedInstance.FindGroupById(UserManager.sharedInstance.currentUser.GroupId!){
                self.group = group
            }
        }
    }
    

}
