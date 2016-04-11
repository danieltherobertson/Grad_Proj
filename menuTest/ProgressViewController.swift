//
//  ProgressViewController.swift
//  menuTest
//
//  Created by Daniel Robertson on 05/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {

    @IBOutlet weak var progressView: ProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let levels = getLevels()
       // progressView.loadLevels(levels)
        
        
        
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
                    if let levels = jsonResult["Levels"] as? [[String: AnyObject]] {
                        
                        for level: [String: AnyObject] in levels {
                            results.append(level)
                        }
                    }
                } catch {}
            } catch {}
        }
        //Returns our juicy data in a lovely array of dictionaries
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
