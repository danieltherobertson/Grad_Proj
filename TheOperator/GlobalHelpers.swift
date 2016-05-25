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

func overwriteGame(viewedSave: GameSave) {
    

        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if paths.count > 0 {
            let directPath = paths[0]
            let path = directPath.stringByAppendingString("/gameSlots.json")
            
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(path) {
                let data = NSData(contentsOfFile: path)!
                var gameSaves = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Array<GameSave>
                for (index, save) in gameSaves.enumerate() {
                    if save.name == viewedSave.name {
                        //FOUND THE RIGHT SAVE
                        gameSaves[index] = viewedSave
                        
                        let data = NSKeyedArchiver.archivedDataWithRootObject(gameSaves)
                        data.writeToFile(path, atomically: true)
                        
                        break
                    }
                }
                
            }
        }
    
}

