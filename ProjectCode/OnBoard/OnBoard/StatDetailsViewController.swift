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
    @IBOutlet weak var dataToggleSegControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalTime.text = "\(Time)" + " mins"
        totalDistance.text = "\(Distance)" + " m"
        averageSpeed.text = "\(Speed)" + " km/h"
        
        let chartArea = CGRect(x: 0, y: 45, width: self.view.bounds.width, height: self.view.bounds.height / 2)
        
        let chart = TKChart(frame: CGRectInset(chartArea, 15, 30))
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        var randomNumericData = [TKChartDataPoint]()
        for i in 0..<10 {
            randomNumericData.append(TKChartDataPoint(x: i, y: Double(arc4random() % 100)))
        }
        
        
        let chartSeries = TKChartLineSeries(items: randomNumericData)
        chart.addSeries(chartSeries)
        chart.xAxis.title = "Time (min)"
        chart.title().hidden = false
        chart.title().text = "This is a chart demo"
        chart.legend().hidden = false
        
        
    }

    @IBAction func segControlChanged(sender: AnyObject) {
        
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
