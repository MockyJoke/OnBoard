//
//  ImpactDetector.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-12-06.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation

protocol ImpactDetectorDelegate{
    func impactAction()
}

class ImpactDetector : NSObject{
    private let IMPACT_ALERT = 1
    private let OVERRIDE_ALERT = 2
    internal private(set) static var sharedInstance = ImpactDetector()
    var delegate : ImpactDetectorDelegate?
    var detectTimer : NSTimer?
    internal private(set) var impactDetected = false
    internal private(set) var needHelp = false
    private override init(){
        
    }
    
    func StartDetection(pauseOnDetection : Bool = true){
        StopDetection()
        detectTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    func StopDetection(){
        if (detectTimer != nil){
            detectTimer!.invalidate()
        }
    }
    
    // Notify the detector necessary action has taken against help signal
    func resetHelpSignal(){
        var alert = UIAlertView(title: "Are you sure?", message: "Do you really want to stop sending help signal?", delegate: nil, cancelButtonTitle: "Yes") //yes has index 0
        alert.delegate = self
        alert.tag = OVERRIDE_ALERT
        alert.addButtonWithTitle("No")    // no has index 1
        alert.delegate = self
        alert.show()
    }
    
    func update(){
        //detectImpact()
    }
    
    func detectImpact(){
        var acceleration = MotionManager.sharedInstance.GetCurrentAcceleration()
        var absAccel = sqrt((pow(acceleration.x,2))+(pow(acceleration.y,2))+(pow(acceleration.z,2)))
        if (absAccel > 3 && impactDetected==false){
            self.impactDetected = true
            println("User might be in toruble")
            var alert = UIAlertView(title: "Potential Impact Detected", message: "Do you require assistance?", delegate: nil, cancelButtonTitle: "Yes") //yes has index 0
            alert.addButtonWithTitle("No")    // no has index 1
            alert.tag = IMPACT_ALERT
            alert.delegate = self
            alert.show()
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch alertView.tag{
        case IMPACT_ALERT:
            switch buttonIndex{
            case 0:
                println("PLease call emergency or notify my group")
                needHelp = true
            case 1:
                impactDetected=false;
                needHelp = false
            default:
                println("everythings good")
            }
        case OVERRIDE_ALERT:
            switch buttonIndex{
            case 0:
                impactDetected = false
                needHelp = false
            default:
                println("everythings good")
            }
        default :
            println("")
        }
    }
}