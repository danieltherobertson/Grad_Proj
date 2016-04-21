//
//  GameViewController.swift
//  menuTest
//
//  Created by Daniel Robertson on 17/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var gameView: GameView!
    var tutorialDialogue = [NSDictionary]()
    var timer: NSTimer?
    var text: String!
    var currentLevel: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonOne = gameView.gameAnswerOne
        let buttonTwo = gameView.gameAnswerTwo
        let buttonThree = gameView.gameAnswerThree
        let buttonFour = gameView.gameAnswerFour
        let buttonFive = gameView.gameAnswerFive
        let buttonSix = gameView.gameAnswerSix
        
        getTutorial()
        showLandingScreen()

        buttonOne.setTitle("Button 1", forState: .Normal)
        buttonTwo.setTitle("Button 2", forState: .Normal)
        buttonThree.setTitle("Button 3", forState: .Normal)
        buttonFour.setTitle("Button 4", forState: .Normal)
        buttonFive.setTitle("Button 5", forState: .Normal)
        buttonSix.setTitle("Button 6", forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTutorial() -> [NSDictionary] {
        var results = [NSDictionary]()
        
        if let path = NSBundle.mainBundle().pathForResource("TutorialDialogue", ofType: "json") {
            do {
                //Tries to convert the json to NSData
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                //If that works, it serialises the json into a dictionary called jsonResult
                do {
                    let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    //If that works, we create an array of dictionaries excepting a string as a key and an any object as its value
                    if let dialogues = jsonResult["tutorialDialogues"] as? [[String: AnyObject]] {
                        for dialogue: [String: AnyObject] in dialogues {

                            results.append(dialogue)
                        }
                    }
                } catch {}
            } catch {}
        }
     //   Returns our juicy data in a lovely array of dictionaries
        tutorialDialogue = results
        return results
    }
    
    func showLandingScreen() {
        gameView.introLabel.typeStart("Level \(currentLevel.valueForKey("number")!) \n \n \(currentLevel.valueForKey("name")!)")
        gameView.introLabel.textColor = UIColor.greenColor()
        let timer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(startText), userInfo: nil, repeats: false)
    }
    
    func startText() {
        print("hello")
        UIView.animateWithDuration(1, delay: 0.6, options: [], animations: { () -> Void in
            self.gameView.introLabel.textColor = UIColor.greenColor()
            self.gameView.introLabel.alpha = 0
            self.gameView.introLabel.enabled = false
        }) { (completion) -> Void in
        }

        
        let dialogue = String(tutorialDialogue[0].valueForKey("text")!)
        // let half = dialogue.characters.count/2
        let half = dialogue.componentsSeparatedByString("\n")
        let first = half.first
        let second = half.last
        gameView.gameText.textColor = UIColor.blackColor()
        gameView.gameText.text = ""
        
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(1, delay: 1.5, options: [], animations: { () -> Void in
            self.gameView.labelHeightConstraint.constant = 140
            self.view.layoutIfNeeded()
        }) { (completion) -> Void in
            self.gameView.gameText.typeStart(first!)
        }
    }
    
    func animateTransition(element: AnyObject, time: Double, direction: String) {
        let animation = CATransition()
        animation.duration = time
        animation.type = kCATransitionPush
        animation.subtype = direction
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        element.layer.addAnimation(animation, forKey: nil)
    }
    
    func drawButtons() {
        animateTransition(gameView.gameAnswerOne, time: 1.2, direction: kCATransitionFromLeft)
        animateTransition(gameView.gameAnswerTwo, time: 1.4, direction: kCATransitionFromLeft)
        animateTransition(gameView.gameAnswerThree, time: 1.6, direction: kCATransitionFromLeft)
        animateTransition(gameView.gameAnswerFour, time: 1.6, direction: kCATransitionFromRight)
        animateTransition(gameView.gameAnswerFive, time: 1.4, direction: kCATransitionFromRight)
        animateTransition(gameView.gameAnswerSix, time: 1.2, direction: kCATransitionFromRight)
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
