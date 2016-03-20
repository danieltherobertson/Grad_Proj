//
//  GameSave.swift
//  menuTest
//
//  Created by Daniel Robertson on 20/03/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation

class GameSave {
    var name: String!
    var progress: Int!
    
    init(name: String, progress: Int) {
        self.name = name
        self.progress = progress
    }
}