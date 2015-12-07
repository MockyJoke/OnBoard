//
//  DelayExecuter.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-12-06.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation


typealias DelayLoadAction = () -> ()

class DelayExecuter : NSObject{
    private var timer : NSTimer?
    internal private(set) var delayInSeconds : Double
    private var action : DelayLoadAction?
    internal private(set) var completed : Bool
    init(delayInSec : Double){
        completed = false
        delayInSeconds = delayInSec
    }
    
    internal func Execute(){
        //println("New Delay item scheduled")
        action?()
        //print("Task executed")
        completed = true
        timer?.invalidate()
    }
    
    func ScheduleAction(action : ()->()){
        self.action = action
        timer = NSTimer.scheduledTimerWithTimeInterval(delayInSeconds, target: self, selector: "Execute", userInfo: nil, repeats: false)
    }
    
    static func RequestNewDelayLoadItem(delayInsec : Double, action : ()->()) -> DelayExecuter{
        var task = DelayExecuter(delayInSec: delayInsec)
        task.ScheduleAction(action)
        return task
    }
}