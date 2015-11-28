//
//  GroupViewController.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-11-27.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chart = TKChart(frame: CGRectInset(self.view.bounds, 15, 15))
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        var randomNumericData = [TKChartDataPoint]()
        for i in 0..<10 {
            randomNumericData.append(TKChartDataPoint(x: i, y: Double(arc4random() % 100)))
        }
        
        chart.addSeries(TKChartLineSeries(items: randomNumericData))
        
        chart.title().hidden = false
        chart.title().text = "This is a chart demo"
        chart.legend().hidden = false
        
        chart.allowAnimations = true

        // Do any additional setup after loading the view.
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
