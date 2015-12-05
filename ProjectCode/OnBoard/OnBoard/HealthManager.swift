//
//  HealthManager.swift
//  OnBoard
//
//  Created by Louis Chan on 2015-12-05.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import Foundation
import HealthKit

class HealthManager {
    let HKStore : HKHealthStore = HKHealthStore()

    func authorizeHealthKit(completion: ((success:Bool, error:NSError!) -> Void)!) {
        let HKTypesRead = Set(arrayLiteral:[
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass),
            HKObjectType.workoutType()
            ])
    
        let HKTypesWritten = Set(arrayLiteral: [
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned),
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning),
            HKObjectType.workoutType()
            ])
    
        if !HKHealthStore.isHealthDataAvailable()
        {
            let error = NSError(domain: "com.rainbowriders.onboard.ios", code: 343, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
            if( completion != nil )
            {
                completion(success:false, error:error)
            }
            return;
        }
    
        HKStore.requestAuthorizationToShareTypes(HKTypesWritten, readTypes: HKTypesRead) { (success, error) -> Void in
        
            if( completion != nil )
            {
                completion(success:success,error:error)
            }
        }
    }

    func readMostRecentSample(sampleType:HKSampleType , completion: ((HKSample!, NSError!) -> Void)!) {
        let past = NSDate.distantPast() as! NSDate
        let present = NSDate()
        let mostRecentPredicate = HKQuery.predicateForSamplesWithStartDate(past, endDate: present, options: .None)
    
        let limit : Int = 1
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
    
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor])
            { (sampleQuery, results, error ) -> Void in
            
                if let queryError = error {
                    completion(nil,error)
                    return;
                }
        let mostRecentSample = results.first as? HKQuantitySample
            if completion != nil {
                completion(mostRecentSample,nil)
            }
    }
    self.HKStore.executeQuery(sampleQuery)
}
}
