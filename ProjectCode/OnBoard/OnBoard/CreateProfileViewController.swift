//
//  CreateProfileViewController.swift
//  OnBoard
//
//  Created by Louis Chan on 11/7/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emergencyName: UITextField!
    @IBOutlet weak var emergencyTel: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addProfile(sender: AnyObject) {
        UserManager.sharedInstance.CreateNewUser(userName.text, emergeName: emergencyName.text, emergPhone: emergencyTel.text)
        
        NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: nil)
        navigationController?.popViewControllerAnimated(true)
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
