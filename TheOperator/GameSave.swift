//
//  GameSave.swift
//  TheOperator
//
//  Created by Daniel Robertson on 20/03/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation

class GameSave: NSObject, NSCoding {
    var name: String!
    var progress: Int!
    
    init(name: String, progress: Int) {
        self.name = name
        self.progress = progress
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.progress, forKey: "progress")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.progress = aDecoder.decodeObjectForKey("progress") as? Int
    }
}
