//
//  DialogueRetriever.swift
//  menuTest
//
//  Created by Daniel Robertson on 27/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation

class DialogueRetriever {

    class func getDialogue(level: String) -> [NSDictionary] {
        var results = [NSDictionary]()
        
        if let path = NSBundle.mainBundle().pathForResource("LevelDialogues", ofType: "json") {
            do {
                //Tries to convert the json to NSData
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                //If that works, it serialises the json into a dictionary called jsonResult
                do {
                    let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    //If that works, we create an array of dictionaries excepting a string as a key and an any object as its value
                    if let dialogues = jsonResult["levelDialogues"] as?  [String: [ NSDictionary ] ] {
                        
                        if let levelDialogue = dialogues[level] {
                            
                            for dialogue in levelDialogue {
                                if let text = dialogue["text"] as? String {
                                    results.append(dialogue)
                                }
                            }
                        }
                    }
                } catch {}
            } catch {}
        }
        //   Returns our juicy data in a lovely array of dictionaries
        return results
    }
    
    class func checkAnswer(currentLevel: String, answer: String) -> String {
        return ""
    }
}

