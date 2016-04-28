//
//  GameViewController.swift
//  TheOperator
//
//  Created by Daniel Robertson on 17/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var gameView: GameView!
    var levelDialogue = [NSDictionary]()
    var timer: NSTimer?
    var text: String!
    var currentLevel: NSDictionary!
    var buttons = [UIButton]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonOne = gameView.gameAnswerOne
        let buttonTwo = gameView.gameAnswerTwo
        let buttonThree = gameView.gameAnswerThree
        let buttonFour = gameView.gameAnswerFour
        let buttonFive = gameView.gameAnswerFive
        let buttonSix = gameView.gameAnswerSix
        let buttonSingle = gameView.singleButton
        buttons += [buttonOne,buttonTwo,buttonThree,buttonFour,buttonFive,buttonSix,buttonSingle]
        
        for button in buttons {
            button.setTitle("Button \(buttons.indexOf(button)!)", forState: .Normal)
            button.hidden = true
            button.addTarget(self, action: "buttonHandler:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        levelDialogue = DialogueRetriever.getDialogue("tutorialDialogue")
        print(levelDialogue)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        showLandingScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showLandingScreen() {
        let currentLev = String(currentLevel.valueForKey("number")!)
        let currentLevInt = Int(currentLev)
        let currentLevRead = currentLevInt!+1
        
        gameView.introLabel.typeStart("Level \(currentLevRead) \n \n \(currentLevel.valueForKey("name")!)")
        gameView.introLabel.textColor = UIColor.greenColor()
        onTypeComplete = {
            let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.startText), userInfo: nil, repeats: false)
            onTypeComplete = nil
        }

        
    }
    
    func startText() {
        UIView.animateWithDuration(1, delay: 0.6, options: [], animations: { () -> Void in
            self.gameView.introLabel.alpha = 0
            
        }) { (completion) -> Void in
            self.gameView.introLabel.enabled = false
//
//
        }

        
        let dialogue = String(levelDialogue[1].valueForKey("text")!)
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
            onTypeComplete = {
            self.buttons.last?.setTitle("Go on...", forState: .Normal)
            self.buttons.last?.hidden = false
            self.animateTransition(self.buttons.last!, time: 0.7, direction: kCATransitionFromLeft)
            }
        }
    }
    
    func questionHandler(dialogueIndex: Int) {
        
    }
    
    func buttonHandler(sender:UIButton) {
        let buttonAnswer = sender.titleLabel!.text
        var nextDialogue = Int()
        
        outer: for dialogue in levelDialogue {
           let answers = dialogue.valueForKey("acceptedAnswers") as! Array<AnyObject>
            for answer in answers {
                let goTo = answer.valueForKey("goTo")
                let text = String(answer.valueForKey("text")!)

                if text == buttonAnswer! {
                    let goToString = String(goTo!)
                    nextDialogue = Int(goToString)!

                    break outer
                }
            }
        }
        
        questionHandler(nextDialogue)
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
