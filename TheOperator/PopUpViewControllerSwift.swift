//
//  PopUpViewControllerSwift.swift
//  NMPopUpView
//
//  Created by Nikos Maounis on 13/9/14.
//  Copyright (c) 2014 Nikos Maounis. All rights reserved.
//

import UIKit
import QuartzCore

var onPopUpClose: (() -> Void)!


@objc public class PopUpViewControllerSwift : UIViewController {
    
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
        self.popUpView.layer.cornerRadius = 5
        self.popUpView.layer.cornerRadius = 20
        self.popUpView.layer.borderWidth = 4
        self.popUpView.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor    }
    
    public func showInView(aView: UIView!, withImage image : UIImage!, withMessage message: String!, animated: Bool)
    {
        aView.addSubview(self.view)
        let gif = UIImage.gifWithName("operator")
        logoImg!.image = gif
        messageLabel.textColor = .blackColor()
        messageLabel!.text = "Incoming call!"
        
        if animated
        {
            self.showAnimate()
        }
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                    
                }
        });
    }
    
    @IBAction public func closePopup(sender: AnyObject) {
        self.removeAnimate()
        if let callback = onPopUpClose {
            callback ()
        }
    }
}
