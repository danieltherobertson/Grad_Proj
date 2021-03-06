//
//  CallAlertView.swift
//  TheOperator
//
//  Created by Daniel Robertson on 09/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class CallAlertView: UIView {
    
    var onPopUpClose: (() -> Void)!
    var onPopUpOpen: (() -> Void)!
    
    
    @IBOutlet weak var callAlert: UIView!
    @IBOutlet weak var callAlertContainer: UIView!
    @IBOutlet weak var CallAlertInnerContainer: UIView!
    @IBOutlet weak var callAlertImage: UIImageView!
    @IBOutlet weak var callAlertMessage: UILabel!
    @IBOutlet weak var callAlertAnswerButton: UIButton!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
       // callAlertContainer.layer.cornerRadius = 5
        callAlertContainer.layer.cornerRadius = 20
        callAlertContainer.layer.borderWidth = 4
        callAlertContainer.layer.borderColor = UIColor(red:190/255, green: 0/255, blue: 0/255, alpha: 1).CGColor
        
        CallAlertInnerContainer.layer.addBorder(.Left, color: UIColor(red:190/255, green: 0/255, blue: 0/255, alpha: 1), thickness: 4)
         CallAlertInnerContainer.layer.addBorder(.Right, color: UIColor(red:190/255, green: 0/255, blue: 0/255, alpha: 1), thickness: 4)
         CallAlertInnerContainer.layer.addBorder(.Top, color: UIColor(red:190/255, green: 0/255, blue: 0/255, alpha: 1), thickness: 4)
        
        callAlertAnswerButton.backgroundColor = UIColor.lightGrayColor()
        callAlertAnswerButton.buttonStyle(callAlertAnswerButton, colour: ButtonColour.Red)
        
        
    }
    
    class func instanceFromNib() -> CallAlertView {
        return UINib(nibName: "callAlertViewNib", bundle: nil).instantiateWithOwner(nil, options: nil).first as! CallAlertView
    }
    
    
    func showInView(aView: UIView!, message: String!, animated: Bool) {
        
        aView.addSubview(self)
        self.center = aView.center
        callAlertMessage.textColor = .whiteColor()
        callAlertMessage!.text = "Incoming call!"
        
        if let callback = onPopUpOpen {
            callback ()
        }
        
        if animated
        {
            self.showAnimate()
        }
    }
    
    func showAnimate()
    {
        self.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.alpha = 0
        UIView.animateWithDuration(0.25, animations: {
            self.alpha = 1.0
            self.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.vibrate()
        });
        
        
    }
    
    func vibrate(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 30
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - 2.5, self.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x + 2.5, self.center.y))
        self.layer.addAnimation(animation, forKey: "position")
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.25, animations: {
            self.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.removeFromSuperview()
                    
                }
        });
    }
    
    
    
    @IBAction func closeCallAlert(sender: AnyObject) {
        self.removeAnimate()
        if let callback = onPopUpClose {
            callback ()
        }

    }
}
