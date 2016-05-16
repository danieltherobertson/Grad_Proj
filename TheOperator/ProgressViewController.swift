//
//  ProgressViewController.swift
//  TheOperator
//
//  Created by Daniel Robertson on 05/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    var currentSave: GameSave!

    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var progressPlayerName: UILabel!
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    var levels = [NSDictionary]()
   // var currentLevel: NSDictionary!
    var selectedLevelPos: Int!
    var selectedLevel = NSDictionary()
    
    var playerName: String!
    var playerProgress: Int!
    var isTutorial = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exitButton.buttonStyle(exitButton)
        startButton.buttonStyle(startButton)
        
        instructions.text = "Select a level to begin!"
        instructions.setLineHeight(3, alignment: .Center)
        
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
        
        progressView.playTutorial = segueToGame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        AudioPlayerController.sharedInstance.fadeOut {
            AudioPlayerController.sharedInstance.startAudio("gameViewAudio")
        }
        
        let gameViewVC = (segue.destinationViewController as? GameViewController)
        let tutorialViewVC = (segue.destinationViewController as? TutorialViewController)

        if segue.identifier == "gameViewSegue" {
            gameViewVC?.currentLevel = selectedLevel
            
        } else {
            tutorialViewVC?.currentLevel = selectedLevel
        }
    }
    
    func startButtonReady(level: Int, tag: Int){
        
        if tag == 2 {
            instructions.text = "Select a level to begin!"
            instructions.setLineHeight(3, alignment: .Center)
            startButton.enabled = false
            startButton.backgroundColor = UIColor.grayColor()
            startButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        }
        else {
        startButton.backgroundColor = UIColor.greenColor()
        startButton.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
        startButton.enabled = true
        
        selectedLevelPos = level
            
        if selectedLevelPos == 0 {
            isTutorial = true
        }
            
        selectedLevel = levels[selectedLevelPos]
        
        startButton.addTarget(nil, action: #selector(segueToGame), forControlEvents: UIControlEvents.TouchUpInside)
        
        let currentLev = String(selectedLevel.valueForKey("number")!)
        let currentLevInt = Int(currentLev)
        let currentLevRead = currentLevInt!+1
        instructions.text = "Level \(currentLevRead) selected"
        
        }
    }
    func segueToGame() {
        if isTutorial {
            performSegueWithIdentifier("tutorialViewSegue", sender: self)
        } else {
            performSegueWithIdentifier("gameViewSegue", sender: self)
        }
        
        
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
