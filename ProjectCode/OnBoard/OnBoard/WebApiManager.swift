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
    
    let baseURL = "http://OnBoardWeb.cloudapp.net/api/"
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
        let u = NSURL(string : url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        let request = NSMutableURLRequest(URL: u!)
        request.HTTPMethod = methond
        var response : NSURLResponse?
        var err : NSError?
        if let responseData = NSURLConnection.sendSynchronousRequest(request,returningResponse: &response, error: &err)
        {
            if let rep = response as? NSHTTPURLResponse
            {
                println("HTTP \(methond) : \(url)")
                println("Server retuned:\(rep.statusCode)")
                if(rep.statusCode >= 200 && rep.statusCode < 300){
                    return JSON(data: responseData)
                }
            }
        }
        return nil
    }
    
}