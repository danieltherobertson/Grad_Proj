//
//  MenuViewController.swift
//  TheOperator
//
//  Created by Daniel Robertson on 29/01/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {

    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var loadGame: UIButton!
    @IBOutlet weak var help: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var tagLine: UILabel!
    
    var text = ""
    var timer: NSTimer?
    var buttons = [UIButton]()
    
   // var operatorTheme = NSURL (fileURLWithPath: NSBundle.mainBundle().pathForResource("Operator_menuAudio2", ofType: "mp3")!)
   // var menuAudio = AVAudioPlayer()

    let gif = UIImage.gifWithName("operator")
    let backgroundGif = UIImage.gifWithName("operator_background_animated")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //AudioPlayerController.sharedInstance.startAudio("operatorTheme")
        // Do any additional setup after loading the view, typically from a nib.

        imageView.image = gif
        
        background.image = backgroundGif

        tagLine.text = text
        
        newGame.alpha = 0
        
        loadGame.alpha = 0
        
        help.alpha = 0
        
        imageView.alpha = 0
        
        newGame.center.x  -= view.bounds.width
        loadGame.center.x  += view.bounds.width
        help.center.x  -= view.bounds.width
        
        buttons.append(newGame);buttons.append(loadGame);buttons.append(help)
        newGame.addTarget(self, action: #selector(disable), forControlEvents: .TouchUpInside)
        
        
        UIView.animateWithDuration(0.7, delay: 0.4, options: [], animations: { () -> Void in
            self.newGame.center.x += self.view.bounds.width
            self.newGame.alpha = 1
            }) { (completion) -> Void in
        }
        
        UIView.animateWithDuration(0.7, delay: 0.6, options: [], animations: { () -> Void in
            self.loadGame.center.x -= self.view.bounds.width
            self.loadGame.alpha = 1
            }) { (completion) -> Void in
        }
        
        UIView.animateWithDuration(0.7, delay: 0.8, options: [], animations: { () -> Void in
            self.help.center.x += self.view.bounds.width
            self.help.alpha = 1
            }) { (completion) -> Void in
        }

    
        
        UIView.animateWithDuration(1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { () in
            self.newGame.alpha = 1
            self.newGame.transform = CGAffineTransformMakeScale(1, 1)
            
            }) { (completion) -> Void in
                
        }
        
        UIView.animateWithDuration(1, delay: 0.8, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { () in
            self.loadGame.alpha = 1
            self.loadGame.transform = CGAffineTransformMakeScale(1, 1)
            
            }) { (completion) -> Void in
                
        }
        
        UIView.animateWithDuration(1, delay: 1.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { () in
            self.help.alpha = 1
            self.help.transform = CGAffineTransformMakeScale(1, 1)
            
            }) { (completion) -> Void in
                
        }
        
        UIView.animateWithDuration(2, delay: 0.5, options: [], animations: { () -> Void in
            self.imageView.alpha = 1
            }) { (completion) -> Void in
               
        }

        newGame.buttonStyleInset(newGame)
        loadGame.buttonStyleInset(loadGame)
        help.buttonStyleInset(help)
        
 
        timer = NSTimer.scheduledTimerWithTimeInterval(1 , target: self, selector: #selector(typeStart), userInfo: nil, repeats: false)
    }
    
    func typeStart() {
        text = "Failure  is  not  an  option."
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.09, target: self, selector: #selector(addNextLetter), userInfo: nil, repeats: true)
        timer!.fire()
    }
    
    func addNextLetter() {
        
        let textArray = Array(text.characters)
        
        if tagLine.text!.characters.count >= textArray.count {
            timer?.invalidate()
        } else {
            let nextLetterIndex = tagLine.text!.characters.count
            let character = textArray[nextLetterIndex]
            tagLine.text = tagLine.text! + String(character)
           // tagLine.font = UIFont(name: "AmericanCaptain", size: 20)
            tagLine.setLineHeight(4, alignment: .Center)
        }
    }



    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "newGameSlotsPush") {
    
            let gameSlotsVC = (segue.destinationViewController as? GameSlotsViewController)
            gameSlotsVC?.pageTitle = "New Game"
            gameSlotsVC?.pageLabel = "Select an empty slot, or select a filled slot to delete that game."
            
            gameSlotsVC?.tagID = 0
        }
            
        if (segue.identifier == "loadGameSlotsPush") {
            
            let gameSlotsVC = (segue.destinationViewController as? GameSlotsViewController)
            gameSlotsVC?.pageTitle = "Load Game"
            gameSlotsVC?.pageLabel = "Select an existing save to continue playing."
            gameSlotsVC?.tagID = 1

                
        }
    
    }
    
    func disable() {
        for button in buttons {
            button.enabled = false
        }
        delay(0.5) { 
            for button in self.buttons {
                button.enabled = false
            }
        }
        
        

    }
}

