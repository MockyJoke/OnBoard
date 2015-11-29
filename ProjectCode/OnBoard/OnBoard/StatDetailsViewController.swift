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
        
        let chartArea = CGRect(x: 0, y: 0, width: self.distanceGraphView.bounds.width, height: self.distanceGraphView.bounds.height)
        
        let chart = TKChart(frame: CGRectInset(chartArea, 15, 5))
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.distanceGraphView.addSubview(chart)
        
        speedGraphView.hidden = true
        altitudeGraphView.hidden = true
        
        var randomNumericData = [TKChartDataPoint]()
        for i in 0..<10 {
            randomNumericData.append(TKChartDataPoint(x: i, y: Double(arc4random() % 100)))
        }
        
        
        let chartSeries = TKChartLineSeries(items: randomNumericData)
        chart.addSeries(chartSeries)
        chart.xAxis.title = "Time (min)"
        chart.title().hidden = true
        chart.title().text = "This is a chart demo"
        chart.legend().hidden = false
        
        
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
