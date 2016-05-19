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
    var rankings: [NSDictionary]!
    
    init(name: String, progress: Int, rankings: [NSDictionary]) {
        self.name = name
        self.progress = progress
        self.rankings = rankings
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.progress, forKey: "progress")
        aCoder.encodeObject(self.rankings, forKey: "rankings")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.progress = aDecoder.decodeObjectForKey("progress") as? Int
        self.rankings = aDecoder.decodeObjectForKey("rankings") as? [NSDictionary]
    }
}
