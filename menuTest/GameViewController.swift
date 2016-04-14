//
//  GameViewController.swift
//  menuTest
//
//  Created by Daniel Robertson on 28/01/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit


class GameViewController: UIViewController, UITextFieldDelegate{
    
    
//    let screenWidth = UIScreen.mainScreen().bounds.size.width
//    let screenHeight = UIScreen.mainScreen().bounds.size.height
//    var questions = [Question]()
//    var activeQuestion: Question {return questions[questionIndex]} //Setting activeQuestion to be the questionIndex position in the array, so that starts as array index 0, so the first question is the default activeQuestion
//    var questionIndex = 0
//    
//    var question1:Question!; var question2:Question!; var question3:Question!; var question4:Question!; var question5:Question!
//    
//    var name:String!
//    var gender:String!
//    
//    var imageDisplay:UIImageView!
//    var image:UIImage!
//    var tintedImage:UIImage!
//    
//    var input:UITextField!
//    var nameSubmit:Bool = false
//    var keyboardSubmit:Bool = false
//    var output:UILabel!
//    var inputBorder:UIView!
//    var lButton:UIButton!; var rButton:UIButton!
//    
//    var timer = NSTimer()
//    var counter = 0
//    
//    var colourButton1:UIButton!; var colourButton2:UIButton!; var colourButton3:UIButton!; var colour:UIColor!
//    
//    var buttonArray = [UIButton!]()
//    
//    var outputText = ""
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        colour = UIColor.greenColor()
//        
//        //Creates questions
//        question1 = Question(title: "I need help, please. My friend's been shot. Oh God please help", acceptedAnswers:["Can you tell me where you are?", "I'll help you. What's your name?"], correctResponce: "", needsKeyboard: false, willBeSaved: false, image: "")
//        question2 = Question(title: "My name's Jeff", acceptedAnswers: ["Okay, Jeff, what's happened?","Okay Jeff, how are you?"], correctResponce: "", needsKeyboard: false, willBeSaved: true, image: "")
//        question3 = Question(title: "My friend's been shot, in the chest. He's unconscious. What do I do?", acceptedAnswers: ["Put him in the recovery position","Fucked if I know lol"], correctResponce: "Okay, I can do that", needsKeyboard: true, willBeSaved: false, image: "")
//        question4 = Question(title: "Red, Green or Blue?", acceptedAnswers: ["Red", "Green", "Blue"], correctResponce: "Did you know you can change the game's colour?", needsKeyboard: true, willBeSaved: false, image: "4.png")
//        question5 = Question(title: "Testing", acceptedAnswers: ["I love bacon","I love bacon"], correctResponce: "Who doesn't?!", needsKeyboard: false, willBeSaved: false, image: "5.png")
//        
//        //Adds questions to questions array
//        questions += [question1,question2,question3,question4,question5]
//        
//        //Draw content+layout
//        
//        imageDisplay = UIImageView(frame:CGRect(x: 10, y: 45, width: screenWidth-20, height: 215))
//        imageDisplay.layer.borderColor = colour.CGColor
//        imageDisplay.layer.borderWidth = 1.0
//       // image = UIImage(named: activeQuestion.image)
//      //  tintedImage = image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
//        imageDisplay.tintColor = colour
//        view.addSubview(imageDisplay)
//        
//        
//        output = PaddedLabel(frame:CGRect(x: 10, y: 270, width: screenWidth-20, height: 100))
//        output.text = outputText
//        output.font = UIFont(name: "Menlo-Regular", size: 16)
//        output.textColor = colour
//        output.textAlignment = NSTextAlignment.Left
//        output.numberOfLines = 0
//        output.layer.borderColor = colour.CGColor
//        output.layer.borderWidth = 1.0
//        view.addSubview(output)
//        
//        input = UITextField(frame: CGRect(x: 10, y: 400, width: screenWidth-20, height: 40))
//        input.attributedPlaceholder =  NSAttributedString(string: "Type here", attributes: [NSForegroundColorAttributeName:colour])
//        input.font = UIFont(name: "Menlo-Regular", size: 16)
//        input.textColor = colour
//        input.textAlignment = NSTextAlignment.Left
//        input.leftView = UIView(frame: CGRectMake(0, 0, 10, 40))
//        input.leftViewMode = UITextFieldViewMode.Always
//        input.autocapitalizationType = UITextAutocapitalizationType.Sentences
//        input.keyboardAppearance = UIKeyboardAppearance.Dark
//        input.layer.borderColor = colour.CGColor
//        input.layer.borderWidth = 1.0
//        input.delegate = self
//        view.addSubview(input)
//        input.hidden = true
//        
//        lButton = UIButton(frame: CGRect(x: 10, y: 400, width: screenWidth-20, height: 50))
//        lButton.backgroundColor = UIColor.blackColor()
//        //lButton.setTitle(question2.acceptedAnswers[0], forState: UIControlState.Normal)
//        lButton.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 16)
//        lButton.setTitleColor(colour, forState: UIControlState.Normal)
//        lButton.addTarget(self, action: "buttonHandler:", forControlEvents: UIControlEvents.TouchUpInside)
//        lButton.layer.borderWidth = 1.0
//        lButton.layer.borderColor = colour.CGColor
//        view.addSubview(lButton)
//        lButton.hidden = true
//        
//        rButton = UIButton(frame: CGRect(x: 10, y: 480, width: screenWidth-20, height: 50))
//        rButton.backgroundColor = UIColor.blackColor()
//        rButton.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 16)
//        rButton.setTitleColor(colour, forState: UIControlState.Normal)
//        rButton.addTarget(self, action: "buttonHandler:", forControlEvents: UIControlEvents.TouchUpInside)
//        rButton.layer.borderWidth = 1.0
//        rButton.layer.borderColor = colour.CGColor
//        view.addSubview(rButton)
//        rButton.hidden = true
//        
//        buttonArray += [lButton,rButton]
//        
//        colourButton1 = UIButton(frame: CGRect(x: screenWidth-110, y: 15, width: 20, height: 20))
//        colourButton1.backgroundColor = UIColor.redColor()
//        colourButton1.setTitle("R", forState: UIControlState.Normal)
//        colourButton1.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 16)
//        colourButton1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        colourButton1.addTarget(self, action: "changeColour:", forControlEvents: UIControlEvents.TouchUpInside)
//        view.addSubview(colourButton1)
//        colourButton2 = UIButton(frame: CGRect(x: screenWidth-70, y: 15, width: 20, height: 20))
//        colourButton2.backgroundColor = UIColor.greenColor()
//        colourButton2.setTitle("G", forState: UIControlState.Normal)
//        colourButton2.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 16)
//        colourButton2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        colourButton2.addTarget(self, action: "changeColour:", forControlEvents: UIControlEvents.TouchUpInside)
//        view.addSubview(colourButton2)
//        colourButton3 = UIButton(frame: CGRect(x: screenWidth-30, y: 15, width: 20, height: 20))
//        colourButton3.backgroundColor = UIColor.blueColor()
//        colourButton3.setTitle("B", forState: UIControlState.Normal)
//        colourButton3.titleLabel!.font = UIFont(name: "Menlo-Bold", size: 16)
//        colourButton3.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        colourButton3.addTarget(self, action: "changeColour:", forControlEvents: UIControlEvents.TouchUpInside)
//        view.addSubview(colourButton3)
//        
//        view.backgroundColor = UIColor.blackColor()
//        
//        
//
//        
//        
//       // questionHandler(activeQuestion)
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        let ac = UIAlertController(title: "INCOMING CALL!", message: "You have an incoming call", preferredStyle: .Alert)
//        ac.addAction(UIAlertAction(title: "Answer", style: .Default, handler: {(action:UIAlertAction) in self.questionHandler(self.activeQuestion)}))
//        presentViewController(ac, animated: true, completion: nil)
//        print("doot")
//    }
//    
//    func questionHandler(question: Question) {
//        
//        output.text = activeQuestion.title
//        
//        input.hidden = true; lButton.hidden = true; rButton.hidden = true
//        
//        if activeQuestion.needsKeyboard { // If the question's needsKeyboard property is true, unhide the keyboard
//            input.hidden = false
//            print("Keyboard is needed!")
//        } else { // If the question's needsKeyboard property is false, unhide the buttons
//            print("Buttons are needed!")
//            lButton.hidden = false
//            rButton.hidden = false
//        }
//        if activeQuestion.title == "Red, Green or Blue?" {
//            
//        }
//        imageDisplay.image = tintedImage
//        answersHandler()
//    }
//    
//    func answersHandler(){
//        if activeQuestion.needsKeyboard {
//            if  activeQuestion.acceptedAnswers == nil {
//                nameSubmit = true
//                print("We're on Question 1")
//            } else {
//                keyboardSubmit = true
//            }
//        } else if activeQuestion.needsKeyboard == false {
//            output.text = activeQuestion.title
//            lButton.setTitle(activeQuestion.acceptedAnswers![0], forState: UIControlState.Normal)
//            rButton.setTitle(activeQuestion.acceptedAnswers![1], forState: UIControlState.Normal)
//        }
//    }
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool { // Handles the user's answer to Question 0
//        if nameSubmit == true {
//            if input.text == "" || input.text!.containsString(" ") {
//                let ac = UIAlertController(title: "System Error: 3230_ac334", message: "My scans detect no user input", preferredStyle: .Alert)
//                ac.addAction(UIAlertAction(title: "Reset Question", style: .Default, handler: nil))
//                presentViewController(ac, animated: true, completion: nil)
//                input.text = nil //Clears text field
//            }
//            else if input.text != "" {
//                name = input.text //Saves the name to var: name
//                question2.title = "Hello, \(name), what's your gender?"
//                print("Name is set to '\(name)'")
//                view.endEditing(true)
//                output.text = activeQuestion.correctResponce
//                input.text = ""
//                nameSubmit = false
//               timer = NSTimer.scheduledTimerWithTimeInterval(2.3, target:self, selector: Selector("questionAdvance"), userInfo: nil, repeats: false)
//            }
//        }
//        
//        if keyboardSubmit == true {
//            if let _ = activeQuestion.acceptedAnswers!.indexOf(input.text!) {
//                input.text = ""
//                output.text = activeQuestion.correctResponce
//                keyboardSubmit = false
//              timer = NSTimer.scheduledTimerWithTimeInterval(2.3, target:self, selector: Selector("questionAdvance"), userInfo: nil, repeats: false)
//            } else {
//                let ac = UIAlertController(title: "System Error: 3230_ac334", message: "Invalid answer. Accepted answers: \(activeQuestion.acceptedAnswers!)", preferredStyle: .Alert)
//                ac.addAction(UIAlertAction(title: "Reset Question", style: .Default, handler: nil))
//                presentViewController(ac, animated: true, completion: nil)
//                input.text = nil //Clears text field
//            }
//        }
//        return true
//    }
//    
//    func buttonHandler(sender:UIButton){
//        animateBtn(sender as UIButton)
//        if activeQuestion.wilBeSaved == true {
//            if sender == lButton {
//                gender = lButton.titleLabel?.text
//            } else if sender == rButton {
//                gender = rButton.titleLabel?.text
//            }
//            question2.correctResponce = "Gender saved as \(gender)"
//            print("Gender saved as \(gender)")
//        }
//        
//        output.text = activeQuestion.correctResponce
//        timer = NSTimer.scheduledTimerWithTimeInterval(2.3, target:self, selector: Selector("questionAdvance"), userInfo: nil, repeats: false)
//    }
//    
//    func questionAdvance() {
//        ++questionIndex
//        print("Advancing to question \(questionIndex+1)")
//        if questionIndex == questions.count { //If the current question index is equal to the length of questions array, i.e the final question, return from function
//            output.text = "END OF PROTOTYPE ~ SYSTEM LOCK ENABLED"
//            input.hidden = true
//            view.endEditing(true)
//            lButton.hidden = true
//            rButton.hidden = true
//            return
//        }
//        view.endEditing(true)
//        output.text = activeQuestion.title
//       // image = UIImage(named: activeQuestion.image)
//       // tintedImage = image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
//        if questionIndex == 3 {
//            
//        }
//        imageDisplay.image = tintedImage
//        questionHandler(activeQuestion)
//    }
//    
//    func changeColour(sender:UIButton){
//        switch sender {
//        case colourButton1:
//            colour = UIColor.redColor()
//        case colourButton2:
//            colour = UIColor.greenColor()
//        case colourButton3:
//            colour = UIColor.blueColor()
//        default:
//            colour = UIColor.greenColor()
//        }
//        
//        output.textColor = colour
//        output.layer.borderColor = colour.CGColor
//        input.attributedPlaceholder = NSAttributedString(string: "Type here", attributes: [NSForegroundColorAttributeName:colour])
//        input.textColor = colour
//        imageDisplay.layer.borderColor = colour.CGColor
//        imageDisplay.tintColor = colour
//        input.layer.borderColor = colour.CGColor
//        lButton.layer.borderColor = colour.CGColor
//        rButton.layer.borderColor = colour.CGColor
//        lButton.setTitleColor(colour, forState: UIControlState.Normal)
//        rButton.setTitleColor(colour, forState: UIControlState.Normal)
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
}
