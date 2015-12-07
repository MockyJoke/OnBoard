//
//  TripSummaryViewController.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-12-07.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit

class TripSummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var distanceView: UIView!
    //@IBOutlet weak var chartControl: UISegmentedControl!
    @IBOutlet weak var summaryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PlotGraph()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func PlotGraph(){
        // Chart size shared across all versions of the graph
        let chartArea = CGRect(x: 0, y: 0, width: self.distanceView.bounds.width, height: self.distanceView.bounds.height)
        
        // Create Distance graph in distanceGraphView
        let dChart = TKChart(frame: CGRectInset(chartArea, 15, 0))
        dChart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.distanceView.addSubview(dChart)
        
        var randomNumericData = [TKChartDataPoint]()
        for i in 0..<10 {
            randomNumericData.append(TKChartDataPoint(x: i, y: Double(arc4random() % 100)))
        }
        
        let chartSeries = TKChartLineSeries(items: randomNumericData)
        //dChart.backgroundColor = UIColor.redColor()
        
        dChart.addSeries(chartSeries)

        
        // Chart formatting
        dChart.xAxis.labelFormat = ""
        dChart.xAxis.title = "Time (min)"
        //dChart.yAxis.title = "Cal"
        
    }
    // ********** TABLE ***********
    
    func GetCellItems()->[SummaryTableViewItem]{
        var array = [SummaryTableViewItem]()
        let formatter = ".1"
        array.append(SummaryTableViewItem(icon: "location", content: SkiResortDataManager.sharedInstance.SelectedSkiResort!.Name, catagory: "Location"))
        if let session = SessionManager.sharedInstance.CurrentSession{
            array.append(SummaryTableViewItem(icon: "stopwatch", content: session.GetDurationHMSString(), catagory: "Duration"))
        
        array.append(SummaryTableViewItem(icon: "ruler_2", content: "\(session.GetTotalDistance().format(formatter)) m", catagory: "Total distance"))
        
        array.append(SummaryTableViewItem(icon: "speed", content: "\((session.GetAvgSpeed()*3.6).format(formatter)) km/h", catagory: "Average Speed"))
        }
        return array
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = summaryTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TripSummaryTableViewCell
            cell.UpdateCell(GetCellItems()[indexPath.row])
        return cell
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

struct SummaryTableViewItem{
    var Icon : String
    var Content : String
    var Catagory : String
    init(icon : String, content : String, catagory : String){
        Icon = icon
        Content = content
        Catagory = catagory
    }
}
