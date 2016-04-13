//
//  ProgressViewController.swift
//  menuTest
//
//  Created by Daniel Robertson on 05/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    var currentSave: GameSave!

    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var progressPlayerName: UILabel!
    var playerName: String!
    var playerProgress: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(currentSave.name)
        
        //Get levels by calling getLevels and assigning the returned results to let levels. levels is then passed as a param for the progressView's loadLevels func
        let levels = getLevels()
        progressView.loadLevels(levels)
        
        playerName = currentSave.name
        progressPlayerName.text = playerName
        
        playerProgress = currentSave.progress
        
        
    
       
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func getLevels() -> [NSDictionary] {
        var results = [NSDictionary]()
        
        if let path = NSBundle.mainBundle().pathForResource("Levels", ofType: "json") {
            do {
                //Tries to convert the json to NSData
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                    //If that works, it serialises the json into a dictionary called jsonResult
                do {
                    let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    //If that works, we create an array of dictionaries excepting a string as a key and an any object as its value
                    if let levels = jsonResult["levels"] as? [[String: AnyObject]] {
                        
                        for level: [String: AnyObject] in levels {
                            results.append(level)
                        }
                    }
                } catch {}
            } catch {}
        }
        //Returns our juicy data in a lovely array of dictionaries
         print("doot doot\(results)")
        return results
       
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
