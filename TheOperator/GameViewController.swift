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
    var countDownTimer: NSTimer?
    var text: String!
    var currentSave: GameSave!
    var currentLevel: NSDictionary!
    var buttons = [UIButton]()
    var startingTime = Int()
    
    var currentLev: String!
    var currentLevInt: Int!
    var currentLevRead: Int!
    
    var requiredServices = [String]()
    var dispatchServices = [Int]()
    var servicesEvent = [NSDictionary]()
    var headlineGen: (String, Bool)!
    var headline = String()
    var isPassed = Bool()
    
    var remainingTime = String()
    var theIssue = String()
    var dispatchedUnits = String()
    
    
    var currentDialogue = 0
    var specialPoints = 0
    var availableSpecialPoints = Int()
    
    var resumeDialogue: String!
    
    var stageDialogue: NSDictionary!
    var stageAnswers: Array<NSDictionary>!
    var numberOfButtons: Int!
    
    var timeCount: Int!
    var callAlert: CallAlertView!
    var dispatchMenu: DispatchMenuView!
    var pauseMenu: PauseMenuView!
    
    var isTyping = false
    var isTiming = false
    var timeHasStarted = false

    override func viewDidLoad() {
        super.viewDidLoad()
       // print(currentLevel)
        typeSpeed = 0.05
        gameView.skipButton.hidden = true
        //gameView.characterImg.hidden = true
        
        //gameView.characterImg.alpha = 0
        gameView.speakerName.alpha = 0
        gameView.gameText.backgroundColor = .blackColor()
        gameView.gameTextContainer.backgroundColor = .blackColor()
        gameView.dispatchButton.backgroundColor = .grayColor()
        gameView.dispatchButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        
        currentLev = String(currentLevel.valueForKey("number")!)
        currentLevInt = Int(currentLev)
        currentLevRead = currentLevInt!+1
        
        gameView.dispatchButton.addTarget(self, action: #selector(displayDispatchMenu), forControlEvents: .TouchUpInside)
        gameView.pauseButton.addTarget(self, action: #selector(displayPauseMenu), forControlEvents: .TouchUpInside)
        gameView.dispatchButton.enabled = false
        gameView.pauseButton.enabled = false
        
        gameView.levelIndicator.text = "Level \(currentLevRead!)"
        gameView.timeIndicator.text = "Time 00:00"

        let buttonOne = gameView.gameAnswerOne
        let buttonTwo = gameView.gameAnswerTwo
        let buttonThree = gameView.gameAnswerThree
        buttons += [buttonOne,buttonTwo,buttonThree]
        
        for button in buttons {
            button.setTitle(" ", forState: .Normal)
            button.titleLabel?.setLineHeight(10, alignment: .Left)
            button.hidden = true
            button.addTarget(self, action: #selector(buttonHandler), forControlEvents: .TouchUpInside)
        }
        levelDialogue = DialogueRetriever.getDialogue("dialogue\(currentLevRead)")
        stageDialogue = levelDialogue[currentDialogue]
        stageAnswers = stageDialogue.valueForKey("acceptedAnswers") as? Array<NSDictionary>
        print(stageAnswers)
        numberOfButtons = stageAnswers?.count
        gameView.skipButton.addTarget(self, action: #selector(speedType), forControlEvents: .TouchUpInside)
    }
    
    override func viewDidAppear(animated: Bool) {
        showLandingScreen()
    }
    
    func showLandingScreen() { // 1
        gameView.introLabel.typeStart("Level  \(currentLevRead) \n \n \(currentLevel.valueForKey("name")!)")
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
            UIView.animateWithDuration(1.5, delay: 2.2, options: [], animations: { () -> Void in
                self.gameView.gameText.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
                self.gameView.gameTextContainer.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
            }) { (completion) -> Void in
            let dialogue = String(self.levelDialogue[self.currentDialogue].valueForKey("text")!)
            self.resumeDialogue = dialogue
            let character = String(self.levelDialogue[self.currentDialogue].valueForKey("character")!)
            
            self.gameView.speakerName.textColor = .whiteColor()
            self.gameView.speakerName.text = ""
            
            
            self.gameView.gameText.textColor = .whiteColor()
            
            //Animate text view, then call typeStart with the first bit of dialogue. On completion, sets button's title and animates it in.
            
            // self.gameView.characterImg.hidden = false
            self.gameView.speakerName.text = "\(character):"
            if character == "System" {
                self.gameView.gameText.textColor = .orangeColor()
                self.gameView.speakerName.textColor = .orangeColor()
            } else if character == "Chief" {
                self.gameView.gameText.textColor = UIColor(red: 0/255, green: 220/255, blue: 0/255, alpha: 1.0)
                self.gameView.speakerName.textColor = UIColor(red: 0/255, green: 220/255, blue: 0/255, alpha: 1.0)
            } else if character == "Caller" {
                self.gameView.gameText.textColor = .whiteColor()
                self.gameView.speakerName.textColor = .whiteColor()
            }
            self.addCharacterDetails()
            delay(1, closure: {

                self.gameView.gameText.typeStart(dialogue)
                self.isTyping = true
                self.gameView.skipButton.hidden = false
                self.gameView.pauseButton.enabled = true
                
                onTypeComplete = {
                    self.isTyping = false
                    print(self.numberOfButtons)
                    self.layoutHandler(self.numberOfButtons)
                }
                
            })
            
        }
        
    }
    
    func speedType () {
        typeSpeed = 0.01
        gameView.skipButton.enabled = false
        gameView.skipButton.hidden = true
    }
    
    func addCharacterDetails() {
        
        UIView.animateWithDuration(0.5, delay: 0, options: [], animations: { () -> Void in
            // self.gameView.characterImg.alpha = 1
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
            if let buttonAnswer = answer.valueForKey("text") as? String {
                inUseAnswers.append(buttonAnswer)
            }
        }
        if NoOfbuttons == 0 {
            
        } else if NoOfbuttons == 1 {
            let button = self.buttons[0]
            button.hidden = false
            let attributeString = NSMutableAttributedString(string: inUseAnswers.first!)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3
            style.alignment = .Center
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, inUseAnswers.first!.characters.count))
            button.setAttributedTitle(attributeString, forState: .Normal)
        } else if NoOfbuttons > 1 {
            outer: for (index, button) in buttons.enumerate() {
                button.hidden = false
                
                for (index2, answer) in inUseAnswers.enumerate() {
                    if index == index2 {
                        print(answer)
                        //  button.setTitle(answer, forState: .Normal)
                        let attributeString = NSMutableAttributedString(string: answer)
                        let style = NSMutableParagraphStyle()
                        style.lineSpacing = 3
                        style.alignment = .Center
                        attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, answer.characters.count))
                        button.setAttributedTitle(attributeString, forState: .Normal)
                    }
                    
                    if index == NoOfbuttons {
                        inUseAnswers.removeAll()
                        button.hidden = true
                        
                        break outer
                    }
                }
            }
        }
    }
    
    func clearButtons() {
        for button in buttons {
            let attributeString = NSMutableAttributedString(string: "")
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3
            style.alignment = .Center
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, 0))
            button.setAttributedTitle(attributeString, forState: .Normal)
            button.hidden = true
            gameView.dispatchButton.enabled = true
            gameView.dispatchButton.backgroundColor = UIColor(red: 0/255, green: 220/255, blue: 0/255, alpha: 1.0)
            gameView.dispatchButton.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
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
                resumeDialogue = nextDialogue
                let buttons = dialogue.valueForKey("buttons") as! Int
                //And display it in gameText
                gameView.gameText.text = ""
                let character = String(levelDialogue[currentDialogue].valueForKey("character")!)
                self.gameView.speakerName.text = "\(character):"
                if character == "System" {
                    self.gameView.gameText.textColor = .orangeColor()
                    self.gameView.speakerName.textColor = .orangeColor()
                } else if character == "Chief" {
                    self.gameView.gameText.textColor = UIColor(red: 0/255, green: 220/255, blue: 0/255, alpha: 1.0)
                    self.gameView.speakerName.textColor = UIColor(red: 0/255, green: 220/255, blue: 0/255, alpha: 1.0)
                } else if character == "Caller" {
                    self.gameView.gameText.textColor = .whiteColor()
                    self.gameView.speakerName.textColor = .whiteColor()
                }
                gameView.gameText.typeStart(nextDialogue)
                gameView.skipButton.hidden = false
                gameView.skipButton.enabled = true
                
                onTypeComplete = {
                    self.isTyping = false
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
            //  print(answers)
            for answer in answers {
                print(answer)
                if let goTo = answer.valueForKey("goTo") as? Int {
                    let text = String(answer.valueForKey("text")!)
                    if text == buttonAnswer! {
                        if let special = answer.valueForKey("special") as? String{
                            var specialChar = Array(special.characters)
                            for (index,char) in specialChar.enumerate() {
                                if char == "+" {
                                    specialChar.removeAtIndex(index)
                                }
                            }
                            let points = String(specialChar[0])
                            let pointsInt = Int(points)
                            if pointsInt != nil {
                                specialPoints += pointsInt!
                            }
                        }
                        nextDialogue = goTo
                        currentDialogue = nextDialogue
                        stageDialogue = levelDialogue[currentDialogue]
                        stageAnswers = stageDialogue.valueForKey("acceptedAnswers") as? Array<NSDictionary>
                        numberOfButtons = stageAnswers?.count
                        break outer
                    }
                }
            }
        }
        
        if let trigger = stageDialogue.valueForKey("triggersCall") as? Bool {
            if trigger == true {
                sender.hidden = true
                gameView.dispatchButton.enabled = true
                gameView.skipButton.hidden = true
                gameView.skipButton.enabled = false
                clearButtons()
                triggerCall()
                self.questionHandler(nextDialogue, enablesPopUp: true)
            } else if let triggersDispatch = stageDialogue.valueForKey("triggersDispatch") as? Bool {
                if triggersDispatch == true {
                    gameView.gameText.text = ""
                    clearButtons()
                    gameView.gameText.typeStart("Please send help")
                    isTyping = true
                    onTypeComplete = {
                        self.isTyping = false
                        let triggerTime = Int64(2 * (NSEC_PER_SEC))
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), {
                            self.displayDispatchMenu()
                            // self.dispatchMenu.closeButton.enabled = false
                            // self.dispatchMenu.closeButton.hidden = true
                        })
                    }
                } else {
                    sender.hidden = true
                    questionHandler(nextDialogue, enablesPopUp: false)
                }
            }
        }
    }
    
    func triggerCall() {
        clearButtons()
        callAlert = CallAlertView.instanceFromNib()
        callAlert.callAlertAnswerButton.enabled = false
        callAlert.onPopUpClose = {
            if let callGoTo = self.stageDialogue.valueForKey("callGoTo") as? Int {
                let nextDialogue = callGoTo
                self.currentDialogue = nextDialogue
                self.stageDialogue = self.levelDialogue[self.currentDialogue]
                self.stageAnswers = self.stageDialogue.valueForKey("acceptedAnswers") as? Array<NSDictionary>
                print("MEME \(self.stageDialogue)")
                if let timeLimit = self.stageDialogue.valueForKey("timeLimit") as? Int {
                    print(timeLimit)
                    self.startingTime = timeLimit
                    self.timeHasStarted = true
                    self.countDown(timeLimit)
                }
                self.questionHandler(callGoTo, enablesPopUp: false)
            }
        }
        callAlert.showInView(self.view, message: "Incoming Call!", animated: true)
    }

    
    func countDown(time: Int) {
        isTiming = true
        timeCount = time
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        gameView.dispatchButton.enabled = true
        gameView.dispatchButton.backgroundColor = UIColor(red: 0/255, green: 220/255, blue: 0/255, alpha: 1.0)
        gameView.dispatchButton.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
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
                countDownTimer?.invalidate()
            }
            let timeFail = "<Error: Signal lost> \n<Error: No time remaining>\n System log: Call Failed"
            gameView.gameText.text = ""
            clearButtons()
            gameView.gameText.typeStart(timeFail)
            isTyping = true
            onTypeComplete = {
                self.isTyping = false
                let dialogue = ZAlertView(title: "No time remaining", message: "You've run out of time! Do you want to restart the level or exit?", isOkButtonLeft: true, okButtonText: "Restart", cancelButtonText: "Exit", okButtonHandler: { (alertView) in
                    for button in self.buttons {
                        button.setTitle(" ", forState: .Normal)
                        button.titleLabel?.setLineHeight(10, alignment: .Left)
                    }
                    self.gameView.skipButton.enabled = true
                    self.gameView.dispatchButton.enabled = false
                  //  self.gameView.characterImg.alpha = 0
                    self.gameView.speakerName.alpha = 0
                    self.gameView.speakerName.textColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
                    self.gameView.speakerName.text = ""
                    self.gameView.gameText.text = ""
                    self.gameView.timeIndicator.textColor = .greenColor()
                    self.clearButtons()
                    self.currentDialogue = 0
                    self.levelDialogue = DialogueRetriever.getDialogue("tutorialDialogue")
                    self.stageDialogue = self.levelDialogue[self.currentDialogue]
                    self.stageAnswers = self.stageDialogue.valueForKey("acceptedAnswers") as? Array<NSDictionary>
                    self.numberOfButtons = self.stageAnswers?.count
                    alertView.dismiss()
                    self.startText()
                    }, cancelButtonHandler: { (alertView) in
                        self.performSegueWithIdentifier("gameReturnToProgressView", sender: self)
                        alertView.dismiss()
                })
                dialogue.allowTouchOutsideToDismiss = false
                dialogue.show()
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
    
    func displayDispatchMenu() {
        dispatchMenu = DispatchMenuView.instanceFromNib()
        if isTyping {
            gameView.gameText.stopType()
            isTyping = false
            dispatchMenu.resumeType = resumeType
        }
        
        if isTiming {
            countDownTimer?.invalidate()
            isTiming = false
            dispatchMenu.resumeTime = resumeTime
            
        }
        
        dispatchMenu.dispatchSent = levelEnding
        //countDownTimer?.invalidate()
        dispatchMenu.showInView(self.view, animated: true)
        
    }
    
    func displayPauseMenu() {
        
        if isTyping {
            gameView.gameText.stopType()
            isTyping = false
        }
        
        if isTiming {
            countDownTimer?.invalidate()
            isTiming = false
        }
        
        pauseMenu = PauseMenuView.instanceFromNib()
        pauseMenu.resumeType = resumeType
        pauseMenu.resumeTime = resumeTime
        pauseMenu.exitLevelButton.addTarget(nil, action: #selector(returnToProgressView), forControlEvents: .TouchUpInside)
        pauseMenu.showInView(self.view, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let progressVC = (segue.destinationViewController as? ProgressViewController)
        
        
        if segue.identifier == "gameReturnToProgressView" {
            progressVC?.currentSave = currentSave
            AudioPlayerController.sharedInstance.fadeOut {
                AudioPlayerController.sharedInstance.startAudio("operatorTheme")
            }
        }
        
        let resultViewVC = (segue.destinationViewController as? ResultViewViewController)
        if segue.identifier == "gameViewToResultView" || segue.identifier == "tutorialViewToResultView" {
            resultViewVC?.headline = headline
            resultViewVC?.remainingTime = remainingTime
            resultViewVC?.theIssue = theIssue
            resultViewVC?.dispatchedUnits = dispatchedUnits
            let convertedUnits = dispatchConverter(requiredServices)
            resultViewVC?.expectedUnits = convertedUnits
            resultViewVC?.expectedUnitsArray = requiredServices
            resultViewVC?.startingTime = startingTime
            resultViewVC?.availableSpecialPoints = availableSpecialPoints
            resultViewVC?.specialPoints = specialPoints
            resultViewVC?.levelPassed = isPassed
            resultViewVC?.activeSave = currentSave
            resultViewVC?.activeLevel = currentLevInt
        }
    

    }
    
    func returnToProgressView() {
        
        let dialogue = ZAlertView(title: "Exit Level?", message: "Your current progress in this level will not be saved!", isOkButtonLeft: true, okButtonText: "Cancel", cancelButtonText: "Exit", okButtonHandler: { (alertView) in
            alertView.dismiss()
            }, cancelButtonHandler: { (alertView) in
                self.performSegueWithIdentifier("gameReturnToProgressView", sender: self)
                alertView.dismiss()
        })
        dialogue.allowTouchOutsideToDismiss = false
        dialogue.show()
    
    }

    func resumeType () {
       // let currentText = gameView.gameText.text
        if isTyping != true {
        gameView.gameText.typeStart(resumeDialogue)
        }
        
    }
    
    func resumeTime() {
        if isTiming != true && timeHasStarted == true {
            countDown(timeCount)
        }
    }
    
    func levelEnding(dispatched: String) {
        countDownTimer?.invalidate()
        onTypeComplete = {
            
        }
        remainingTime = gameView.timeIndicator.text!
        buttons[1].removeTarget(self, action: #selector(buttonHandler), forControlEvents: .TouchUpInside)
        gameView.skipButton.enabled = false
        gameView.skipButton.hidden = true
        dispatchedUnits = dispatched
        stageAnswers = [["text": "I've dispatched \(dispatched) to your location. Help is coming!"]]
        let buttonText = "I've dispatched \(dispatched) to your location. Help is coming!"
        let servicesConvert = servicesStringToInt(dispatched)
        headlineGen = generateHeadline(servicesConvert, requiredServices: requiredServices, headlines: servicesEvent)
        headline = headlineGen.0
        isPassed = headlineGen.1
        print(isPassed)
        let attributeString = NSMutableAttributedString(string: buttonText)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        style.alignment = .Left
        attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, buttonText.characters.count))
        clearButtons()
        buttons[1].hidden = false
        buttons[1].setAttributedTitle(attributeString, forState: .Normal)
        buttons[1].removeTarget(self, action: #selector(buttonHandler), forControlEvents: .TouchUpInside)
        buttons[1].addTarget(self, action: #selector(randomResponse), forControlEvents: .TouchUpInside)
        gameView.buttonTwoHeightConstraint.constant = 100
        view.layoutIfNeeded()
    }
    
    func randomResponse() {
        buttons[1].enabled = false
        buttons[1].hidden = true
        let random = Int(arc4random_uniform(6))
        let replies = ["Okay, thank you!","Please hurry!","Oh okay...thanks!","Thank you for all your help!","About time! I need help!","Please hurry, get here before it's too late!"]
        let reply = replies[random]
        gameView.gameText.text = ""
        self.gameView.gameText.textColor = .whiteColor()
        self.gameView.speakerName.textColor = .whiteColor()
        gameView.gameText.typeStart(reply)
        onTypeComplete = {
            let triggerTime = Int64(2 * (NSEC_PER_SEC))
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), {
                self.segueToResultsView()
            })
        }
    }
    
    func segueToResultsView(){
        performSegueWithIdentifier("gameViewToResultView", sender: self)
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
}
