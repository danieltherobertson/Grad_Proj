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
