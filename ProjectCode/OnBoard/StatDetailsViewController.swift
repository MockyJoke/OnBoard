//
//  StatDetailsViewController.swift
//  
//
//  Created by Louis Chan on 2015-11-09.
//
//

import UIKit

class StatDetailsViewController: UIViewController {
    
    var Time : Int!
    var Distance: Int!
    var Speed : Int!

    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var averageSpeed: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Speed)
        totalTime.text = "\(Time)" + " mins"
        totalDistance.text = "\(Distance)" + " m"
        averageSpeed.text = "\(Speed)" + " km/h"
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
