//
//  TripViewController.swift
//  OnBoard
//
//  Created by George Cui on 11/7/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit
import CoreMotion


class TripViewController: UIViewController, UIAlertViewDelegate {
    // Outlet declarations
    @IBOutlet weak var graphZoneView: UIView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var endSessionButton: UIButton!
    var impactDetected = false
   
    // class-wise members
    var recentAccelerationData = [CMAcceleration]()
    var updateTimer : NSTimer?
    var user : User?
    var tempUser : User?
    var graph : TKChart?
    var dataSeries : TKChartLineSeries?
    override func viewDidLoad(){
        super.viewDidLoad()
        ImpactDetector.sharedInstance.StartDetection()
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "update", userInfo: nil, repeats: true)
        user = UserManager.sharedInstance.currentUser
        for i in 0...9{
            recentAccelerationData.append(MotionManager.sharedInstance.GetCurrentAcceleration())
        }
        InitializeGraph()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Called when subview is drawed
    override func viewDidLayoutSubviews() {
        
        let gridStyle = graph!.gridStyle()
        gridStyle.horizontalAlternateFill = nil
        gridStyle.horizontalFill = nil
        gridStyle.horizontalLinesHidden = true
    }
    
    @IBAction func stopSession(sender: AnyObject) {
        SessionManager.sharedInstance.EndCurrentSession()
        updateTimer?.invalidate()
        endSessionButton.hidden = true
        UserManager.sharedInstance.Save()
        print(NSUserDefaults.standardUserDefaults().dictionaryRepresentation())
        print(UserManager.sharedInstance.currentUser.SessionArray![0].SnapshotArray.count)

    }
    func UpdateRecentAccelerationData( acceleration : CMAcceleration){
        if(recentAccelerationData.count>10){
            recentAccelerationData.removeAtIndex(0)
        }
        recentAccelerationData.append(acceleration)
    }
    
    func update(){
        UpdateRecentAccelerationData(MotionManager.sharedInstance.GetCurrentAcceleration())
        UpdateGraph()
        UpdateDurationLabel()
        SessionManager.sharedInstance.CurrentSession?.TakeSnapshot()
        UserManager.sharedInstance.currentUser
        //outputAccelerationData(MotionManager.sharedInstance.GetCurrentAcceleration())
        
    }
    
  
    // Dudation Label management
    func UpdateDurationLabel(){
        if let session = SessionManager.sharedInstance.CurrentSession {
            durationLabel.text = session.GetDurationHMSString()
        }
    }
    
    func GetPlotData()-> [TKChartDataPoint] {
        var myData = [TKChartDataPoint]()
        for (var i = 0; i < recentAccelerationData.count ;i++){
            var test = TKChartDataPoint(x: i, y: recentAccelerationData[i].x)
            myData.append(test)
        }
        return myData as [TKChartDataPoint]
    }
    
    func InitializeGraph() {
        let graphArea = CGRect(x: 0, y: 0, width: self.graphZoneView.bounds.width, height: self.graphZoneView.bounds.height)
        
        graph = TKChart(frame: CGRectInset(graphArea, 0, 15))
        graph!.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.graphZoneView.addSubview(graph!)
        
        dataSeries = TKChartSplineSeries(items: GetPlotData())
        
        let fill = TKLinearGradientFill(colors: [UIColor(red: 0.92, green: 0.53, blue: 0.18, alpha: 1),
            UIColor(red: 0.95, green: 0.33, blue: 1.0, alpha: 1),
            UIColor(red: 0.18, green: 0.58, blue: 0.92, alpha: 1)])
        
        dataSeries!.style.stroke = TKStroke(fill: fill, width: 2.0)
        graph!.addSeries(dataSeries)
        
        graph!.xAxis.hidden = true
        graph!.yAxis.hidden = true
        graphZoneView.addSubview(graph!)
    }
    
    func UpdateGraph(){
        // Do any additional setup after loading the view.
        graph?.removeAllData()
        dataSeries = TKChartSplineSeries(items: GetPlotData())
        //dataSeries = TKChartSplineAreaSeries ( items: GetPlotData())
        let fill = TKLinearGradientFill(colors: [UIColor(red: 0.92, green: 0.53, blue: 0.18, alpha: 1),
            UIColor(red: 0.95, green: 0.33, blue: 1.0, alpha: 1),
            UIColor(red: 0.18, green: 0.58, blue: 0.92, alpha: 1)])

        /*dataSeries!.style.fill = TKGradientFill (colors: [UIColor(red: 39.0/255.0, green: 2.0/255.0, blue: 178.0/255.0, alpha: 1),
            UIColor(red: 0, green: 0, blue: 0, alpha: 0),
            UIColor(red: 39.0/255.0, green: 2.0/255.0, blue: 178.0/255.0, alpha: 1)
            ]
        )*/
        //dataSeries!.style.fill = TKSolidFill (color: UIColor(red: 39.0/255.0, green: 2.0/255.0, blue: 178.0/255.0, alpha: 1))
        //dataSeries!.style.stroke = TKStroke(color: UIColor(red: 177.0/255.0, green: 156.0/255.0, blue: 255.0/255.0, alpha: 1), width: 2.0)
        graph!.addSeries(dataSeries)
        graph!.xAxis.hidden = true
        graph!.yAxis.hidden = true
        
    }
    
    

    
//    func PlotGraph(){
//        // Do any additional setup after loading the view.
//        
//        var x = graphZoneView.frame.width * 0.05;
//        var y = graphZoneView.frame.height * 0.05;
//        var width = graphZoneView.frame.width * 0.9
//        var height = graphZoneView.frame.height * 0.9
//        
//        let graph = StatusGraphView(frame: CGRectMake(x,y,width,height), data: GetPlotData())
//        for view in graphZoneView.subviews {
//            view.removeFromSuperview()
//        }
//        graphZoneView.addSubview(graph)
//        
//    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}
