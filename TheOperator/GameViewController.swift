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
    
    var currentLev: String!
    var currentLevInt: Int!
    var currentLevRead: Int!
    
    var currentDialogue = 0
    
    var stageDialogue: NSDictionary!
    var stageAnswers: Array<NSDictionary>!
    var numberOfButtons: Int!
    
    var popViewController: PopUpViewControllerSwift = PopUpViewControllerSwift(nibName: "PopUpViewController", bundle: nil)

    override func viewDidLoad() {
        
        currentLev = String(currentLevel.valueForKey("number")!)
        currentLevInt = Int(currentLev)
        currentLevRead = currentLevInt!+1
        
        gameView.levelIndicator.text = "Level \(currentLevRead!)"
        
        super.viewDidLoad()

        let buttonOne = gameView.gameAnswerOne
        let buttonTwo = gameView.gameAnswerTwo
        let buttonThree = gameView.gameAnswerThree
        buttons += [buttonOne,buttonTwo,buttonThree]
        
        for button in buttons {
            button.setTitle(" ", forState: .Normal)
            button.hidden = true
            button.addTarget(self, action: #selector(buttonHandler), forControlEvents: UIControlEvents.TouchUpInside)
        }
        levelDialogue = DialogueRetriever.getDialogue("tutorialDialogue")
        stageDialogue = levelDialogue[currentDialogue]
        stageAnswers = stageDialogue.valueForKey("acceptedAnswers") as? Array<NSDictionary>
        numberOfButtons = stageAnswers?.count
        print("number of buttons: \(numberOfButtons!)")
    }
    
    override func viewDidAppear(animated: Bool) {
        showLandingScreen()
    }
    
    func showLandingScreen() { // 1
        gameView.introLabel.typeStart("Level \(currentLevRead) \n \n \(currentLevel.valueForKey("name")!)")
        gameView.introLabel.textColor = UIColor.greenColor()
        onTypeComplete = {
            let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.startText), userInfo: nil, repeats: false)
            onTypeComplete = nil
        }
    }
    
    func startText() { // 2
        UIView.animateWithDuration(1, delay: 0.6, options: [], animations: { () -> Void in
            //hide intro label
            self.gameView.introLabel.alpha = 0
        }) { (completion) -> Void in
            self.gameView.introLabel.enabled = false
        }
        //get next dialogue, starts at 0 for start of level.
        let dialogue = String(levelDialogue[currentDialogue].valueForKey("text")!)
        gameView.gameText.textColor = UIColor.blackColor()
        gameView.gameText.text = ""
        //Animate text view, then call typeStart with the first bit of dialogue. On completion, sets button's title and animates it in.
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(1, delay: 1.5, options: [], animations: { () -> Void in
            self.gameView.labelHeightConstraint.constant = 140
            self.view.layoutIfNeeded()
        }) { (completion) -> Void in
            self.gameView.gameText.typeStart(dialogue)
            onTypeComplete = {
                self.layoutHandler(self.numberOfButtons)
            }
        }
    }
    
    func layoutHandler(NoOfbuttons: Int) {
        var inUseAnswers = [String]()
        
        clearButtons()
        
        for answer in stageAnswers {
            let buttonAnswer = String(answer.valueForKey("text")!)
            inUseAnswers.append(buttonAnswer)
        }

        if NoOfbuttons == 1 {
            let button = self.buttons[0]
            button.hidden = false
            button.setTitle(inUseAnswers.first, forState: .Normal)
            
        } else {
            outer: for (index, button) in buttons.enumerate() {
                button.hidden = false
                
                for (index2, answer) in inUseAnswers.enumerate() {
                    if index == index2 {
                        button.setTitle(answer, forState: .Normal)
                    }
                    
                    if index == NoOfbuttons {
                        inUseAnswers.removeAll()
                        button.hidden = true
                        button.setTitle("", forState: .Normal)
                        break outer
                    }
                }
            }
        }
    }
    
    func clearButtons() {
        for button in buttons {
            button.setTitle("", forState: .Normal)
            button.hidden = true
        }
    }
    
    func questionHandler(dialogueIndex: Int) {
        
        //Getting all of the dialogue sets for the current level
        for dialogue in levelDialogue {
            //number is the first property of each dialogue set, identifying its index in the current level dialogue
            let number = dialogue.valueForKey("number")! as! Int
            //if number is equal to dialogueIndex (which is the piece of dialogue that is to be displayed next, passed from buttonHandler), then we know we've looped to the piece of dialogue we want to display next.
            if number == dialogueIndex {
                //So we then set nextDialogue to be the text value of the dialogue set at that index.
                let nextDialogue = dialogue.valueForKey("text") as! String
                let buttons = dialogue.valueForKey("buttons") as! Int
                //And display it in gameText
                gameView.gameText.text = ""
                gameView.gameText.typeStart(nextDialogue)
                onTypeComplete = {
                    self.layoutHandler(buttons)
                }

            }
        }
    }
    
    func buttonHandler(sender:UIButton) {
        clearButtons()
        let senderButton = sender
        let buttonAnswer = sender.titleLabel!.text

        var nextDialogue = Int()
        
        outer: for dialogue in levelDialogue {
            let answers = dialogue.valueForKey("acceptedAnswers") as! Array<AnyObject>
            for answer in answers {
                let goTo = answer.valueForKey("goTo") as! Int
                let text = String(answer.valueForKey("text")!)

                if text == buttonAnswer! {
                    nextDialogue = goTo
                    currentDialogue = nextDialogue
                    stageDialogue = levelDialogue[currentDialogue]
                    stageAnswers = stageDialogue.valueForKey("acceptedAnswers") as? Array<NSDictionary>
                    numberOfButtons = stageAnswers?.count
                    break outer
                }
            }
        }
        if let trigger = stageDialogue.valueForKey("triggersCall") as? Bool {
            if trigger == true {
                sender.hidden = true
                triggerCall()
                self.questionHandler(nextDialogue)
                
                onPopUpClose = {
                    if let callGoTo = self.stageDialogue.valueForKey("callGoTo") as? Int {
                        
                        let nextDialogue = callGoTo
                        self.currentDialogue = nextDialogue
                        self.stageDialogue = self.levelDialogue[self.currentDialogue]
                        self.stageAnswers = self.stageDialogue.valueForKey("acceptedAnswers") as? Array<NSDictionary>
                        
                        self.questionHandler(callGoTo)
                    }
                }
                
            } else {
                sender.hidden = true
                questionHandler(nextDialogue)
            }
        }
    }
    
    func triggerCall() {
        let bundle = NSBundle(forClass: PopUpViewControllerSwift.self)
        if (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController_iPad", bundle: bundle)
            self.popViewController.title = "This is a popup view"
            self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "Incoming call!", animated: true)
        } else
        {
            if UIScreen.mainScreen().bounds.size.width > 320 {
                if UIScreen.mainScreen().scale == 3 {
                    self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController_iPhone6Plus", bundle: bundle)
                    self.popViewController.title = "This is a popup view"
                    self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "Incoming call!", animated: true)
                } else {
                    self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController_iPhone6", bundle: bundle)
                    self.popViewController.title = "This is a popup view"
                    self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "Incoming call!", animated: true)
                }
            } else {
                self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController", bundle: bundle)
                self.popViewController.title = "This is a popup view"
                self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "Incoming call!", animated: true)
            }
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
