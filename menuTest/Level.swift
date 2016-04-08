//
//  Level.swift
//  menuTest
//
//  Created by Daniel Robertson on 07/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation

class Level: NSObject {
    var calls: [Call]!
    var numberOfCalls: Int!
    var statuses = ["Completed", "Unlocked", "Locked"]
    var currentStatus: String!
}