//
//  WebApiManager.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/20/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation


typealias ServiceResponse = (JSON, NSError?) -> Void

class WebApiManager : NSObject{
    // Singleton object for the manager
    internal private(set) static var sharedInstance = WebApiManager()
    
    let baseURL = "http://OnBoardWeb.cloudapp.net/api/users"
    private override init(){
        
    }
    
    
    
    
    func MakeHTTPGetRequest(url: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data)
            onCompletion(json, error)
        })
        task.resume()
    }
    
    func MakeHTTPPostRequest(url: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data)
            onCompletion(json, error)
        })
        task.resume()
    }
    
    
    func MakeHTTPRequestSync(url: String, methond : String) -> JSON?{
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = methond
        var response : AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        if let responseData = NSURLConnection.sendSynchronousRequest(request,returningResponse: response, error:nil)
        {
            return JSON(responseData)
        }else{
            return nil
        }
    }
    
}