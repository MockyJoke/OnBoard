//
//  StartupViewController.swift
//  OnBoard
//
//  Created by Rainbow Riders on 15/11/4.
//  Copyright © 2015 Rainbow Riders. All rights reserved.
//

import UIKit

class StartupViewController: UIViewController {

    @IBOutlet weak var sessionButton: UIButton!
    
    @IBOutlet weak var prevSessionButton: UIButton!
    
    @IBOutlet weak var changeProfileButton: UIButton!
    
    var updatedName = ""
    
    @IBOutlet weak var currentUserNote: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.sessionButton.layer.cornerRadius = 10
        self.prevSessionButton.layer.cornerRadius = 10
        self.changeProfileButton.layer.cornerRadius = 10
        
        self.updatedName = UserManager.sharedInstance.currentUser.Name
        currentUserNote.text = "Using OnBoard as: \(updatedName)"
    }
    
    override func viewWillAppear(animated: Bool) {
        self.updatedName = UserManager.sharedInstance.currentUser.Name
        currentUserNote.text = "Using OnBoard as: \(updatedName)"
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
