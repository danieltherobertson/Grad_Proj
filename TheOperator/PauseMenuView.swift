//
//  PauseMenuView.swift
//  TheOperator
//
//  Created by Daniel Robertson on 15/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class PauseMenuView: UIView {
    
    let shadow = UIView()
    var resumeType: (() -> ())?
    var resumeTime: (() -> ())?
    
    @IBOutlet weak var gamePausedLabel: UILabel!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var exitLevelButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 20
        gamePausedLabel.textColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
        containerView.layer.borderColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0).CGColor
        containerView.layer.borderWidth = 4
        containerView.layer.cornerRadius = 20
        
        resumeButton.buttonStyle(resumeButton)
        exitLevelButton.buttonStyle(exitLevelButton,colour: .PauseRed)
        
    }
    
    class func instanceFromNib() -> PauseMenuView{
        return UINib(nibName: "pauseMenuViewNib", bundle: nil).instantiateWithOwner(nil, options: nil).first as! PauseMenuView
    }

    func showInView(mainView: UIView!, animated: Bool) {
        shadow.frame = UIScreen.mainScreen().bounds
        shadow.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        
        shadow.addSubview(self)
        mainView.addSubview(shadow)
        self.center = shadow.center

        if animated {
            self.showAnimate()
        }
    }
    
    func showAnimate() {
        self.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.alpha = 0
        shadow.transform = CGAffineTransformMakeScale(1.3, 1.3)
        shadow.alpha = 0
        UIView.animateWithDuration(0.25, animations: {
            self.alpha = 1.0
            self.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.shadow.alpha = 1.0
            self.shadow.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animateWithDuration(0.25, animations: {
            self.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.alpha = 0.0
            self.shadow.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.shadow.alpha = 0.0
            }, completion:{(finished : Bool)  in
                if (finished) {
                    self.removeFromSuperview()
                }
        });
    }
    
    @IBAction func resumeGame(sender: AnyObject) {
        if let resumeType = resumeType {
            resumeType()
        }
        
        if let resumeTime = resumeTime {
            resumeTime()
        }
        removeAnimate()
    }

    

    
    
}
