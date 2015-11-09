//
//  StatisticsTableViewController.swift
//  OnBoard
//
//  Created by Louis Chan on 11/8/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit

class StatisticsTableViewController: UITableViewController {
    
    var chosenDate : String = ""
    
    // TODO: Remove Placeholder values
    let tempDates = [
        "Anonymous":["11/4/15","11/1/15","10/27/15","10/13/15"], "Dan":["11/3/15","1/3/15","10/12/14"]]
    
    var tempDateValues = ["11/4/15":[10232, 74, 32], "11/3/15":[13234,89,43], "10/27/15":[1232,20,10]]
    
    var currentUser = UserManager.sharedInstance.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserManager.sharedInstance.CreateNewUser("Bob", emergeName: "", emergPhone: "")
        //if (UserManager.sharedInstance)
        //UserManager.sharedInstance.SpecifyCurrentUser("Bob")
        currentUser = UserManager.sharedInstance.currentUser
        self.title = "Statistics"

        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return tempDates[tempDates.keys.array[0]]!.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        let text = cell?.textLabel?.text
        if let date = text {
            chosenDate = date
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = tempDates[tempDates.keys.array[0]]![indexPath.row]
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            var editArray = tempDates["\(currentUser.Name)"]!
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }  
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var statDetailVC = segue.destinationViewController as! StatDetailsViewController
        statDetailVC.title = chosenDate
        
        if currentUser.Name == "Bob" {
            statDetailVC.Time = 43
            statDetailVC.Distance = 3054
            statDetailVC.Speed = 28
        }
        else {
            statDetailVC.Time = 54
            statDetailVC.Distance = 5003
            statDetailVC.Speed = 42
        }
    }

}
