//
//  TripViewController.swift
//  OnBoard
//
//  Created by George Cui on 11/7/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit
import CoreMotion


class TripViewController: UIViewController {

    @IBOutlet weak var graphZoneView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        PlotGraph()
    }
    
    func PlotGraph(){
        let myData = [
            ["label" : "Mon",   "value" : NSNumber(int:15)],
            ["label" : "Tues",  "value" : NSNumber(int:30)],
            ["label" : "Weds",  "value" : NSNumber(int:7)],
            ["label" : "Thurs", "value" : NSNumber(int:60)],
            ["label" : "Fri",   "value" : NSNumber(int:30)],
            ["label" : "Sat",   "value" : NSNumber(int:15)],
            ["label" : "Sun",   "value" : NSNumber(int:45)],
            ] as NSArray
        // Do any additional setup after loading the view.
        
        var x = graphZoneView.frame.width * 0.05;
        var y = graphZoneView.frame.height * 0.05;
        var width = graphZoneView.frame.width * 0.9
        var height = graphZoneView.frame.height * 0.9
        
        let graph = StatusGraphView(frame: CGRectMake(x,y,width,height), data: myData)
        for view in graphZoneView.subviews {
            view.removeFromSuperview()
        }
        graphZoneView.addSubview(graph)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    //Instance Variables
    
    var currentMaxAccelerationX : Double = 0.00
    var currentMaxAccelerationY : Double = 0.00
    var currentMaxAccelerationZ : Double = 0.00
    
    var currentMaxRotationX : Double = 0.00
    var currentMaxRotationY : Double = 0.00
    var currentMaxRotationZ : Double = 0.00
    
    var motionManager = CMMotionManager()
    
    //Outlets
    
    @IBOutlet var AccelerationX : UILabel?
    @IBOutlet var AccelerationY : UILabel?
    @IBOutlet var AccelerationZ : UILabel?
    
    @IBOutlet var RotationX : UILabel?
    @IBOutlet var RotationY : UILabel?
    @IBOutlet var RotationZ : UILabel?
    
    @IBOutlet var MaxAccelerationX : UILabel?
    @IBOutlet var MaxAccelerationY : UILabel?
    @IBOutlet var MaxAccelerationZ : UILabel?
    
    @IBOutlet var MaxRotationX : UILabel?
    @IBOutlet var MaxRotationY : UILabel?
    @IBOutlet var MaxRotationZ : UILabel?
    
    //Functions
    
    @IBAction func resetMaxValues() {
        currentMaxAccelerationX = 0
        currentMaxAccelerationY = 0
        currentMaxAccelerationZ = 0


        currentMaxRotationX = 0
        currentMaxRotationY = 0
        currentMaxRotationZ = 0
        
    }
    
    func viewDidload(){
        super.viewDidLoad()
        self.resetMaxValues()
        
        motionManager.accelerometerUpdateInterval = 1.0
        motionManager.gyroUpdateInterval = 1.0
        
        MotionManager.sharedInstance.StartUpdate()
        println(MotionManager.sharedInstance.GetCurrentAcceleration().x)
         println(MotionManager.sharedInstance.GetCurrentAcceleration().y)
         println(MotionManager.sharedInstance.GetCurrentAcceleration().z)
    }
    
        func outputAccelerationData(acceleration: CMAcceleration) {
            AccelerationX?.text = "\(acceleration.x)1fg"
            
            if fabs(acceleration.x) > fabs(currentMaxAccelerationX){
                
                currentMaxAccelerationX = acceleration.x
            }
            
            
            AccelerationY?.text = "\(acceleration.x)1fg"
            
            if fabs(acceleration.y) > fabs(currentMaxAccelerationY){
                
                currentMaxAccelerationX = acceleration.x
            }
            
            AccelerationZ?.text = "\(acceleration.z)1fg"
            
            if fabs(acceleration.x) > fabs(currentMaxAccelerationZ){
                
                currentMaxAccelerationZ = acceleration.z
            }
    }
    
        //start recording
        //motionBegan(motion: UIEventSubtype, withEvent: UIEvent)
        
      /*
    //    motionManager.startAccelerometerUpdatesToQueue(queue: NSOperationQueue!) { (CMAccelerometerData!, NSError,!) -> Void in
            self.outputAccelerationData (accerlerometerData.acceleration)
            if (error != nil){
                println("\(error)")
            }
        }
        
        motionManager.startGyroUpdatesToQueue(queue: NSOperationQueue!) { (<#CMGyroData!#>, <#NSError!#>) -> Void in
            code
        }
        
      motionManager.startAccelerometerUpdatesToQueue(<#queue: NSOperationQueue!#>, withHandler: <#CMAccelerometerHandler!##(CMAccelerometerData!, NSError!) -> Void#>)
    }
    
    
    
    

*/
    
    
}
