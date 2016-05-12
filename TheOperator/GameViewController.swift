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
    
    var timeCount: Int!
    var callAlert: CallAlertView!
  
   // var popViewController: PopUpViewControllerSwift = PopUpViewControllerSwift(nibName: "PopUpViewController", bundle: nil)

    override func viewDidLoad() {
        gameView.skipButton.hidden = true
        gameView.characterImg.hidden = true
        
        gameView.characterImg.alpha = 0
        gameView.speakerName.alpha = 0
        
        currentLev = String(currentLevel.valueForKey("number")!)
        currentLevInt = Int(currentLev)
        currentLevRead = currentLevInt!+1
        
        gameView.levelIndicator.text = "Level \(currentLevRead!)"
        gameView.timeIndicator.text = "Time 00:00"
        
        super.viewDidLoad()

        let buttonOne = gameView.gameAnswerOne
        let buttonTwo = gameView.gameAnswerTwo
        let buttonThree = gameView.gameAnswerThree
        buttons += [buttonOne,buttonTwo,buttonThree]
        
        for button in buttons {
            button.setTitle(" ", forState: .Normal)
            button.hidden = true
            button.addTarget(self, action: #selector(buttonHandler), forControlEvents: .TouchUpInside)
        }
        levelDialogue = DialogueRetriever.getDialogue("tutorialDialogue")
        stageDialogue = levelDialogue[currentDialogue]
        stageAnswers = stageDialogue.valueForKey("acceptedAnswers") as? Array<NSDictionary>
        numberOfButtons = stageAnswers?.count
        gameView.skipButton.addTarget(self, action: #selector(speedType), forControlEvents: .TouchUpInside)
    }
    
    override func viewDidAppear(animated: Bool) {
        showLandingScreen()
    }
    
    func showLandingScreen() { // 1
        gameView.introLabel.typeStart("Level \(currentLevRead) \n \n \(currentLevel.valueForKey("name")!)")
        gameView.introLabel.textColor = UIColor.greenColor()
        onTypeComplete = {
            let _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.startText), userInfo: nil, repeats: false)
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
        let character = String(levelDialogue[currentDialogue].valueForKey("character")!)
        print(character)
        
        gameView.speakerName.textColor = .blackColor()
        gameView.speakerName.text = ""
        
        gameView.gameText.textColor = .blackColor()
        
        //Animate text view, then call typeStart with the first bit of dialogue. On completion, sets button's title and animates it in.
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(1, delay: 1.5, options: [], animations: { () -> Void in
            self.gameView.gameTextContainerHeightConstraint.constant = 200
            self.view.layoutIfNeeded()
        }) { (completion) -> Void in
            self.gameView.characterImg.hidden = false
            self.gameView.speakerName.text = character
            self.gameView.speakerName.text = "\(character):"
            self.addCharacterDetails()
            self.gameView.gameText.typeStart(dialogue)
            self.gameView.skipButton.hidden = false
            
            onTypeComplete = {
                self.layoutHandler(self.numberOfButtons)
            }
        }
    }
    
    func speedType () {
        typeSpeed = 0.01
        gameView.skipButton.enabled = false
        gameView.skipButton.hidden = true
    }
    
    func addCharacterDetails() {
        
        UIView.animateWithDuration(0.5, delay: 0, options: [], animations: { () -> Void in
            self.gameView.characterImg.alpha = 1
            self.gameView.speakerName.alpha = 1
        }) { (completion) -> Void in

        }
    }
    
    func layoutHandler(NoOfbuttons: Int) {
        var inUseAnswers = [String]()
        
        gameView.skipButton.hidden = true
        gameView.skipButton.enabled = false
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
    
    func questionHandler(dialogueIndex: Int, enablesPopUp: Bool) {
        
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
                gameView.skipButton.hidden = false
                gameView.skipButton.enabled = true
                onTypeComplete = {
                    self.layoutHandler(buttons)
                    
                    if enablesPopUp {
                        self.callAlert.callAlertAnswerButton.backgroundColor = UIColor(red: 255/255, green: 218/255, blue: 31/255, alpha: 1.0)
                        self.callAlert.callAlertAnswerButton.enabled = true
                    }
                }
            }
        }
    }
    
    func buttonHandler(sender:UIButton) {
        clearButtons()
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
                gameView.skipButton.hidden = true
                gameView.skipButton.enabled = false
                triggerCall()
                self.questionHandler(nextDialogue, enablesPopUp: true)
                
            } else {
                sender.hidden = true
                questionHandler(nextDialogue, enablesPopUp: false)
            }
        }
    }
    
    func triggerCall() {
        callAlert = CallAlertView.instanceFromNib()
        callAlert.callAlertAnswerButton.enabled = false
        callAlert.onPopUpClose = {
            print("POP UP CLOSE")
            if let callGoTo = self.stageDialogue.valueForKey("callGoTo") as? Int {
                let nextDialogue = callGoTo
                self.currentDialogue = nextDialogue
                self.stageDialogue = self.levelDialogue[self.currentDialogue]
                self.stageAnswers = self.stageDialogue.valueForKey("acceptedAnswers") as? Array<NSDictionary>
                
                if let timeLimit = self.stageDialogue.valueForKey("timeLimit") as? Int {
                    self.countDown(timeLimit)
                }
                self.questionHandler(callGoTo, enablesPopUp: false)
            }
        }
        callAlert.showInView(self.view, message: "Incoming Call!", animated: true)
    }
    
    func countDown(time: Int) {
        timeCount = time
        let _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    func update(count: Int) {
        if timeCount > 10 {
            timeCount! -= 1
            let time = secondsToHoursMinutesSeconds(timeCount!)
            gameView.timeIndicator.text = String("Time \(time)")
        } else if timeCount == 0 {
            if gameView.timeIndicator.textColor == UIColor.redColor() {
                gameView.timeIndicator.textColor = .greenColor()
            } else {
                gameView.timeIndicator.textColor = .redColor()
            }
        } else if timeCount <= 10 && timeCount > 0 {
            if gameView.timeIndicator.textColor == UIColor.redColor() {
                gameView.timeIndicator.textColor = .greenColor()
            } else {
                gameView.timeIndicator.textColor = .redColor()
            }
            
            timeCount! -= 1
            let time = secondsToHoursMinutesSeconds(timeCount!)
            gameView.timeIndicator.text = String("Time \(time)")
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> String {
        let secondsRaw = (seconds % 3600) % 60
        var secondsConverted = String()
        if secondsRaw < 10 {
            secondsConverted = "0\(secondsRaw)"
            return "0\(((seconds % 3600) / 60)):\(secondsConverted)"
        } else {
            return "0\(((seconds % 3600) / 60)):\((seconds % 3600) % 60)"
        }
    }
//    func animateTransition(element: AnyObject, time: Double, direction: String) {
//        let animation = CATransition()
//        animation.duration = time
//        animation.type = kCATransitionPush
//        animation.subtype = direction
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//        element.layer.addAnimation(animation, forKey: nil)
//    }
//    
//    func drawButtons() {
//        animateTransition(gameView.gameAnswerOne, time: 1.2, direction: kCATransitionFromLeft)
//        animateTransition(gameView.gameAnswerTwo, time: 1.4, direction: kCATransitionFromLeft)
//        animateTransition(gameView.gameAnswerThree, time: 1.6, direction: kCATransitionFromLeft)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
