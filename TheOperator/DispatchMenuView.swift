//
//  DispatchMenuView.swift
//  TheOperator
//
//  Created by Daniel Robertson on 13/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class DispatchMenuView: UIView {
    
    var onPopUpClose: (() -> Void)!
    var onPopUpOpen: (() -> Void)!
    

    
    @IBOutlet weak var dispatchViewTitle: UILabel!
    @IBOutlet weak var dispatchViewMessage: UILabel!
    
    @IBOutlet weak var policeLabel: UILabel!
    @IBOutlet weak var policeSwitch: UISwitch!
    
    @IBOutlet weak var ambulanceLabel: UILabel!
    @IBOutlet weak var ambulanceSwitch: UISwitch!
    
    @IBOutlet weak var fireLabel: UILabel!
    @IBOutlet weak var fireSwitch: UISwitch!
    
    @IBOutlet weak var dispatchButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class func instanceFromNib() -> DispatchMenuView {
        return UINib(nibName: "dispatchMenuViewNib", bundle: nil).instantiateWithOwner(nil, options: nil).first as! DispatchMenuView
    }
    
    func showInView(aView: UIView!, message: String!, animated: Bool) {
        aView.addSubview(self)
        self.center = aView.center
        
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