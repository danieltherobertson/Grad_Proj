//
//  GlobalHelpers.swift
//  TheOperator
//
//  Created by Daniel Robertson on 19/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func generateHeadline (dispatchedServices: [Int], requiredServices: [String], headlines: [NSDictionary]) -> String {
    var dispatchedServicesString = [String]()
    var wrongServices = [String]()
    var rightServices = [String]()
    var missingServices = [String]()
    var service1 = [String]()
    var service2 = [String]()
    var service3 = [String]()
    var failHeadlines = [String]()
    var passHeadlines = [String]()
    
    //Convert dispatched services to strings
    for service in dispatchedServices {
        if service == 0 {
            dispatchedServicesString.append("Police")
        } else if service == 1 {
            dispatchedServicesString.append("Ambulance")
        } else if service == 2 {
            dispatchedServicesString.append("Fire Brigade")
        }
    }
    print(dispatchedServicesString)
    
    for requiredService in requiredServices {
        for dispatchedService in dispatchedServicesString {
            if dispatchedServicesString.contains(requiredService) == false && missingServices.contains(requiredService) == false {
                missingServices.append(requiredService)
            }
            if dispatchedServicesString.contains(requiredService) && rightServices.contains(requiredService) == false {
                rightServices.append(requiredService)
            }
            if requiredServices.contains(dispatchedService) == false && wrongServices.contains(dispatchedService) == false {
                wrongServices.append(dispatchedService)
            }
        }
    }
//    print(missingServices)
//    print(rightServices)
//    print(wrongServices)
    
    //Getting the ifFails and ifPresent headlines for each requiredService, seperating them out into Police headlines, Ambulance headlines and Fire headlines
  //  print(headlines)
    for item in headlines {
        if let serviceToDispatch = item.valueForKey("service") as? String {
           // print(serviceToDispatch)
            if let ifFails = item.valueForKey("ifFails") as? String {
                if let ifPresent = item.valueForKey("ifPresent") as? String {
                    if serviceToDispatch == "Police" {
                        service1.append(serviceToDispatch); service1.append(ifFails); service1.append(ifPresent)
                    }
                    if serviceToDispatch == "Ambulance" {
                        service2.append(serviceToDispatch); service2.append(ifFails); service2.append(ifPresent)
                    }
                    if serviceToDispatch == "Fire Brigade" {
                        service3.append(serviceToDispatch); service3.append(ifFails); service3.append(ifPresent)
                    }
                }
            }
        }
    }
    
//    print(service1)
//    print(service2)
//    print(service3)
    
    //Finding the headlines that match to each missing and correct service, adding those headlines to an array of fail headlines and an array of pass headLines
    for missingService in missingServices {
        if missingService == service1.first {
            failHeadlines.append(service1[1])
        }
        if missingService == service2.first {
            failHeadlines.append(service2[1])
        }
        if missingService == service3.first {
            failHeadlines.append(service3[1])
        }
    }
    print(rightServices)
    for rightService in rightServices {
        if rightService == service1.first {
            passHeadlines.append(service1[2])
        }
        if rightService == service2.first {
            passHeadlines.append(service2[2])
        }
        if rightService == service3.first {
            passHeadlines.append(service3[2])
        }
    }
    print("PASS \(passHeadlines)")
    print("FAIL \(failHeadlines)")
    
    return ""
}



