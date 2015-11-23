//
//  AppDelegate.swift
//  OnBoard
//
//  Created by Rainbow Riders on 15/11/4.
//  Copyright © 2015 Rainbow Riders. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        /*var defaults = NSUserDefaults.standardUserDefaults()
        var objectData = NSKeyedArchiver.archivedDataWithRootObject(Ball())
        defaults.setObject(objectData, forKey: "TEST_BALL")
        defaults.synchronize()
        var modelData = defaults.objectForKey("TEST_BALL") as! NSData
        var b = NSKeyedUnarchiver.unarchiveObjectWithData(modelData) as! Ball
        print(b.Name)*/
        CoreLocationManager.sharedInstance.StartUpdate()
        for resort in SkiResortDataManager.sharedInstance.SkiResortArray{
            println(resort.Name)
        }
        MotionManager.sharedInstance.StartUpdate()
        let baseURL = "http://OnBoardWeb.cloudapp.net/api/users"
        WebApiManager.sharedInstance.MakeHTTPGetRequest(baseURL, onCompletion : { json, error -> Void in
            var count = json.count
            for (var i = 0 ;i  < count ; i++ ) {
                var j = json[i]
                var k = j["Name"].string!
                print (k)
            }
        })
        
        //let url = "http://OnBoardWeb.cloudapp.net/api/users/17"
        //var json = WebApiManager.sharedInstance.MakeHTTPRequestSync(url, methond: "PUT")
        //OnlineServiceManager.sharedInstance.FindGroupById(3)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

