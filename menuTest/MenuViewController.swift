//
//  MenuViewController.swift
//  menuTest
//
//  Created by Daniel Robertson on 29/01/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var loadGame: UIButton!
    @IBOutlet weak var help: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newGame.alpha = 0
        newGame.transform = CGAffineTransformMakeScale(0, 0)
        
        loadGame.alpha = 0
        loadGame.transform = CGAffineTransformMakeScale(0, 0)
        
        help.alpha = 0
        help.transform = CGAffineTransformMakeScale(0, 0)
        
        imageView.alpha = 0
        
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
        
        buttonStyle(newGame)
        buttonStyle(loadGame)
        buttonStyle(help)
        
    }
    
    func buttonStyle(button: UIButton) -> UIButton {
        
        let button = button
        
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
        
        return button
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "newGameSlotsPush") {
    
            let gameSlotsVC = (segue.destinationViewController as? GameSlotsViewController)
            gameSlotsVC?.pageTitle = "New Game"
            
            gameSlotsVC?.tagID = 0
        }
            
        if (segue.identifier == "loadGameSlotsPush") {
            
            let gameSlotsVC = (segue.destinationViewController as? GameSlotsViewController)
            gameSlotsVC?.pageTitle = "Load Game"
            
            gameSlotsVC?.tagID = 1

                
        }
    
    }
}

