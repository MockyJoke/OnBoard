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
    

    @IBOutlet weak var groupStatusLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupIdLabel: UILabel!
    @IBOutlet weak var groupMembersLabel: UILabel!
    @IBOutlet weak var groupSubView: UIView!
    
    // ----------------------- General Grouping ---------------------------
    func promtAnonymous(){
        let alert = UIAlertView(title: "Error", message: "You can not join a group as an anonymous user. Create a profile before retrying.", delegate: nil, cancelButtonTitle: nil)
    }

    // ----------------------- Group Joining ------------------------------
    var joinAlertTextField: UITextField!
    @IBAction func joinGroupAction(sender: AnyObject) {
        
        var g : Group?
        var alert = UIAlertController(title: "Join a group", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler(configurationJoinGroupTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:handleJoinGroupCancel))
        alert.addAction(UIAlertAction(title: "Search", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            OnlineServiceManager.sharedInstance.CreateUserOnServer(UserManager.sharedInstance.GetCurrentUser())
            
            if let group = OnlineServiceManager.sharedInstance.FindGroupById(self.joinAlertTextField.text.toInt()!){
                if let user = OnlineServiceManager.sharedInstance.JoinGroup(UserManager.sharedInstance.GetCurrentUser(), groupId: group.Id)
                {
                    if let g = OnlineServiceManager.sharedInstance.FindGroupById(self.joinAlertTextField.text.toInt()!)
                    {
                        self.groupStatusLabel.text = ""
                        self.groupSubView.hidden = false;
                        self.groupNameLabel.text = "\(g.Name)"
                        self.groupIdLabel.text = "\(g.Id)"
                        self.groupMembersLabel.text = " \(g.GroupUsers[0].Name) and \(g.GroupUsers.count-1) more."
                    }
                }
                
                
            }
        }))
        self.presentViewController(alert, animated: true, completion: {
            println("completion block")
        })
        

    }
    
    func handleJoinGroupCancel(alertView: UIAlertAction!)
    {
        println("Cancelled !!")
    }
    
    func configurationJoinGroupTextField(textField: UITextField!)
    {
        textField.keyboardType = UIKeyboardType.NumberPad
        //textField.returnKeyType = UIReturnKeyType.Go
        textField.placeholder = "Enter a group ID"
        textField.text = String(6)
        joinAlertTextField = textField
    }
    // -----------------------End of Group Joining -------------------------
    
    // ----------------------- Create Group --------------------------------
    var createGroupAlertTextField: UITextField!
    @IBAction func createGroupAction(sender: AnyObject) {
        var alert = UIAlertController(title: "Create a group", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler(configurationCreateGroupTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:handleCreateGroupCancel))
        alert.addAction(UIAlertAction(title: "Create", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            OnlineServiceManager.sharedInstance.CreateUserOnServer(UserManager.sharedInstance.GetCurrentUser())
            if let group = OnlineServiceManager.sharedInstance.CreateGroup(self.createGroupAlertTextField.text){
                OnlineServiceManager.sharedInstance.JoinGroup(UserManager.sharedInstance.currentUser, groupId: group.Id)
                if let g = OnlineServiceManager.sharedInstance.FindGroupById(group.Id)
                {
                    self.groupStatusLabel.text = ""
                    self.groupSubView.hidden = false;
                    self.groupNameLabel.text = "\(g.Name)"
                    self.groupIdLabel.text = "\(g.Id)"
                    self.groupMembersLabel.text = " \(g.GroupUsers[0].Name) and \(g.GroupUsers.count-1) more."
                }
            }
        }))
        self.presentViewController(alert, animated: true, completion: {
            println("completion block")
        })
    }
    
    func handleCreateGroupCancel(alertView: UIAlertAction!)
    {
        println("Cancelled !!")
    }
    
    func configurationCreateGroupTextField(textField: UITextField!)
    {
        textField.returnKeyType = UIReturnKeyType.Go
        textField.placeholder = "Enter a group Name"
        createGroupAlertTextField = textField
    }
    // ---------------------- End of Create Group ---------------------------
    

    @IBAction func toggleMapType(sender: AnyObject) {
        if let toggle = sender as? UISwitch{
            mapView.mapType = toggle.on ? MKMapType.Hybrid : MKMapType.Standard
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.groupSubView.hidden = true;
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

