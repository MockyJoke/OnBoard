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

    @IBOutlet weak var distanceGraphView: UIView!
    @IBOutlet weak var speedGraphView: UIView!
    @IBOutlet weak var altitudeGraphView: UIView!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var averageSpeed: UILabel!
    @IBOutlet weak var dataToggleSegControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalTime.text = "\(Time)" + " mins"
        totalDistance.text = "\(Distance)" + " m"
        averageSpeed.text = "\(Speed)" + " km/h"
        
        // Chart size shared across all versions of the graph
        let chartArea = CGRect(x: 0, y: 0, width: self.distanceGraphView.bounds.width, height: self.distanceGraphView.bounds.height)
        
        // Create Distance graph in distanceGraphView
        let dChart = TKChart(frame: CGRectInset(chartArea, 15, 0))
        dChart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.distanceGraphView.addSubview(dChart)
        
        // Create Speed graph in speedGraphView
        let sChart = TKChart(frame: CGRectInset(chartArea, 15, 0))
        sChart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.speedGraphView.addSubview(sChart)
        
        // Create Altitude graph in altitudeGraphView
        let aChart = TKChart(frame: CGRectInset(chartArea, 15, 0))
        aChart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.altitudeGraphView.addSubview(aChart)
        
        // Hiding graphs not currently selected
        speedGraphView.hidden = true
        altitudeGraphView.hidden = true
        
        //TODO: Insert actual data
        var randomNumericData = [TKChartDataPoint]()
        for i in 0..<10 {
            randomNumericData.append(TKChartDataPoint(x: i, y: Double(arc4random() % 100)))
        }
        
        var randomNumericData2 = [TKChartDataPoint]()
        for i in 0..<10 {
            randomNumericData2.append(TKChartDataPoint(x: i, y: Double(arc4random() % 100)))
        }
        
        var randomNumericData3 = [TKChartDataPoint]()
        for i in 0..<10 {
            randomNumericData3.append(TKChartDataPoint(x: i, y: Double(arc4random() % 100)))
        }
        
        
        let chartSeries = TKChartLineSeries(items: randomNumericData)
        let chartSeries2 = TKChartLineSeries(items: randomNumericData2)
        let chartSeries3 = TKChartLineSeries(items: randomNumericData3)
        
        dChart.addSeries(chartSeries)
        sChart.addSeries(chartSeries2)
        aChart.addSeries(chartSeries3)
        
        // Chart formatting
        dChart.xAxis.title = "Time (min)"
        sChart.xAxis.title = "Time (min)"
        aChart.xAxis.title = "Time (min)"
        
    }

    @IBAction func segControlChanged(sender: AnyObject) {
        switch dataToggleSegControl.selectedSegmentIndex {
        case 0: distanceGraphView.hidden = false
                speedGraphView.hidden = true
                altitudeGraphView.hidden = true
        case 1: distanceGraphView.hidden = true
                speedGraphView.hidden = false
                altitudeGraphView.hidden = true
        case 2: distanceGraphView.hidden = true
                speedGraphView.hidden = true
                altitudeGraphView.hidden = false
        default:
            break
        }
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
