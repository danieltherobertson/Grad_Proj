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
    @IBOutlet weak var callAlertImage: UIImageView!
    @IBOutlet weak var callAlertMessage: UILabel!
    @IBOutlet weak var callAlertAnswerButton: UIButton!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
        callAlert.layer.cornerRadius = 5
        callAlert.layer.cornerRadius = 20
        callAlert.layer.borderWidth = 4
        callAlert.layer.borderColor = UIColor(red: 190/255, green: 0/255, blue: 0/255, alpha: 1).CGColor
        callAlertAnswerButton.backgroundColor = UIColor.lightGrayColor()
        callAlertAnswerButton.buttonStyle(callAlertAnswerButton, colour: ButtonColour.Red)
        
    }
    
    class func instanceFromNib() -> CallAlertView {
        return UINib(nibName: "callAlertViewNib", bundle: nil).instantiateWithOwner(nil, options: nil).first as! CallAlertView
    }
    
    
    func showInView(aView: UIView!, message: String!, animated: Bool)
    {
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
        });
        
        
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
