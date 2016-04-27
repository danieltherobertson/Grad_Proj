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
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    var levels = [NSDictionary]()
   // var currentLevel: NSDictionary!
    var selectedLevelPos: Int!
    var selectedLevel = NSDictionary()
    
    var playerName: String!
    var playerProgress: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exitButton.buttonStyle(exitButton)
        startButton.buttonStyle(startButton)
        
        startButton.enabled = false
        startButton.backgroundColor = UIColor.grayColor()
        startButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        //Get levels by calling getLevels and assigning the returned results to let levels. levels is then passed as a param for the progressView's loadLevels func
        levels = getLevels()
        progressView.loadLevels(levels)
        
        playerName = currentSave.name
        progressPlayerName.text = playerName
        
        progressView.viewedSave = currentSave
        
        progressView.currentGameSelected = startButtonReady
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let gameViewVC = (segue.destinationViewController as? GameViewController)

        
        if segue.identifier == "startGame" {
            gameViewVC?.currentLevel = selectedLevel
            
        }
    }
    
    func startButtonReady(level: Int){
        startButton.backgroundColor = UIColor.greenColor()
        startButton.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
        startButton.enabled = true
        selectedLevelPos = level
        selectedLevel = levels[selectedLevelPos]
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
        return results
       
    }
    
    @IBAction func exitButton(sender: AnyObject) {
        let dialogue = ZAlertView(title: "Return to menu?", message: "Are you sure you want to return to the main menu? All progress will be saved", isOkButtonLeft: true, okButtonText: "Canel", cancelButtonText: "Yes",
              okButtonHandler: { alertView in
                alertView.dismiss()
            },
              cancelButtonHandler: { alertView in
                self.navigationController?.popToRootViewControllerAnimated(true)
                alertView.dismiss()
            }
        )
        dialogue.allowTouchOutsideToDismiss = false
        dialogue.show()
    }
}
