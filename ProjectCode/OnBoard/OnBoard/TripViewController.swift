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

    
    override func viewDidLoad(){
        super.viewDidLoad()
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
        self.resetMaxValues()
        
        motionManager.accelerometerUpdateInterval = 1.0
        motionManager.gyroUpdateInterval = 1.0
        
        MotionManager.sharedInstance.StartUpdate()
        println(MotionManager.sharedInstance.GetCurrentAcceleration().x)
        println(MotionManager.sharedInstance.GetCurrentAcceleration().y)
        println(MotionManager.sharedInstance.GetCurrentAcceleration().z)
    }
    
    func update(){
        
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
    
    @IBOutlet weak var AccelerationX: UILabel!
    @IBOutlet weak var AccelerationY: UILabel!
    @IBOutlet weak var AccelerationZ: UILabel!
    
    /* Max values, should move to Statistics page (after active session)
    @IBOutlet var MaxAccelerationX : UILabel?
    @IBOutlet var MaxAccelerationY : UILabel?
    @IBOutlet var MaxAccelerationZ : UILabel?
    */
    
    /* gyroscope data display
    
    @IBOutlet var RotationX : UILabel?
    @IBOutlet var RotationY : UILabel?
    @IBOutlet var RotationZ : UILabel?
    
    @IBOutlet var MaxRotationX : UILabel?
    @IBOutlet var MaxRotationY : UILabel?
    @IBOutlet var MaxRotationZ : UILabel?
    */
    
    //Functions
    
    @IBAction func resetMaxValues() {
        currentMaxAccelerationX = 0
        currentMaxAccelerationY = 0
        currentMaxAccelerationZ = 0


        currentMaxRotationX = 0
        currentMaxRotationY = 0
        currentMaxRotationZ = 0
        
    }
    
    
    func outputAccelerationData(acceleration :CMAcceleration)
    {
        AccelerationX.text = "\(acceleration.x)"
            
        if fabs(acceleration.x) > fabs(currentMaxAccelerationX)
        {
                
            currentMaxAccelerationX = acceleration.x
        }
            
            
            AccelerationY.text = "\(acceleration.x)"
            
        if fabs(acceleration.y) > fabs(currentMaxAccelerationY)
        {
                
            currentMaxAccelerationX = acceleration.x
        }
            
        AccelerationZ.text = "\(acceleration.z)"
            
        if fabs(acceleration.x) > fabs(currentMaxAccelerationZ)
        {
                
            currentMaxAccelerationZ = acceleration.z
        }
    }
    
    
    
    //Implementing a timer (to call outputAccelerationData, but also can double as a stopwatch display)
    
    var timer = NSTimer()
    var counter = 0
    
    @IBOutlet weak var timerlabel: UILabel!
    
    @IBAction func startTimer(sender: AnyObject)
    {
        
    }
    
    @IBAction func stopTimer(sender: AnyObject)
    {
        
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
