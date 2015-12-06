//
//  CreateProfileViewController.swift
//  OnBoard
//
//  Created by Louis Chan on 11/7/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation
import UIKit
import HealthKit

class CreateProfileViewController: UIViewController, UITextFieldDelegate {
    
    let healthManager : HealthManager = HealthManager()
    var weight: HKQuantitySample?
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emergencyName: UITextField!
    @IBOutlet weak var emergencyTel: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBAction func authorizeHK(sender: AnyObject) {
        healthManager.authorizeHealthKit { (authorized,  error) -> Void in
            if authorized {
                println("HealthKit authorization received.")
            }
            else
            {
                println("HealthKit authorization denied.")
                if error != nil {
                    println("\(error)")
                }
            }
        }
    }
    
    @IBAction func retrieveHKData(sender: AnyObject) {
        self.weightLabel.hidden = false
        let sampleQty = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        
        self.healthManager.readMostRecentSample(sampleQty, completion: { (mostRecentWeight, error) -> Void in
            if error != nil {
                println("Error reading weight from HKStore: \(error.localizedDescription)")
                return
            }
            
            var weightStr = "Unknown"
            self.weight = mostRecentWeight as! HKQuantitySample?
            if let kilograms = self.weight?.quantity.doubleValueForUnit(HKUnit.gramUnitWithMetricPrefix(.Kilo)) {
                let weightFormatter = NSMassFormatter()
                weightFormatter.forPersonMassUse = true;
                weightStr = weightFormatter.stringFromKilograms(kilograms)
            }
            
            self.weightLabel.text = weightStr
        })
    }
    
    @IBAction func addProfile(sender: AnyObject) {
        var newUser = UserManager.sharedInstance.CreateNewUser(userName.text, emergeName: emergencyName.text, emergPhone: emergencyTel.text, wght: weight)
        OnlineServiceManager.sharedInstance.CreateUserOnServer(newUser)
        // Send signal for ProfileSetup view controller to refresh table
        navigationController?.popViewControllerAnimated(true)
        /*NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);*/
        NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == self.userName {
            self.emergencyName.becomeFirstResponder()
        }
        else if textField == self.emergencyName {
            self.emergencyTel.becomeFirstResponder()
        }
        
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Create Profile"
        self.addButton.layer.cornerRadius = 10
        self.weightLabel.hidden = true
        
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
