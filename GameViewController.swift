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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        animateTransition(gameView.gameAnswerOne, time: 1.2, direction: kCATransitionFromLeft)
        animateTransition(gameView.gameAnswerTwo, time: 1.4, direction: kCATransitionFromRight)
        animateTransition(gameView.gameAnswerThree, time: 1.6, direction: kCATransitionFromLeft)
        
        
        getTutorial()
        
        gameView.gameText.setLineHeight(3)
        
        let dialogue = String(tutorialDialogue[0].valueForKey("text")!)
       // let half = dialogue.characters.count/2
        let half = dialogue.componentsSeparatedByString("\n")
        let first = half.first
        let second = half.last
        
        gameView.gameText.textColor = UIColor.blackColor()

        gameView.gameAnswerOne.setTitle("Jack", forState: .Normal)
        gameView.gameAnswerTwo.setTitle("Gene Parmesan", forState: .Normal)
        gameView.gameAnswerThree.setTitle("Gordon", forState: .Normal)
        
//        gameView.gameText.text = first
        gameView.gameText.text = ""
        gameView.gameText.typeStart(first!)
        
    
//      typeStart(first!)

        // Do any additional setup after loading the view.
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

               // print("TRYING \(results[0])")
                //print("TRYING AGAIN \(results[2])")

        tutorialDialogue = results
        return results
    }
    
    func typeStart(dialogue: String) {
        let text = dialogue
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.09, target: self, selector: #selector(addNextLetter), userInfo: text, repeats: true)
        timer!.fire()
    }
    
    func addNextLetter(timer: NSTimer) {

        
        let text = timer.userInfo as! String
        
        let textArray = Array(text.characters)

        
        if gameView.gameText.text!.characters.count >= textArray.count {
            timer.invalidate()

        } else {
            let nextLetterIndex = gameView.gameText.text!.characters.count
            let character = textArray[nextLetterIndex]
            gameView.gameText.text = gameView.gameText.text! + String(character)
            print(gameView.gameText.text)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
   
    

}
