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
    
    var services = [UISwitch]()
    var enabledServices = [Int]()
 
    var enabledServicesCount = Int()
    
    let shadow = UIView()
    var resume: (() -> ())?

    @IBOutlet weak var innerContainer: UIView!
    
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
        
        innerContainer.layer.borderWidth = 4
        innerContainer.layer.borderColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0).CGColor
        self.layer.cornerRadius = 5
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        enabledServicesCount = 0
        
        dispatchButton.backgroundColor = .lightGrayColor()
        dispatchButton.setTitleColor(.darkGrayColor(), forState: .Normal)
        dispatchButton.layer.borderWidth = 4
        dispatchButton.layer.borderColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0).CGColor
        
        dispatchViewTitle.textColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
        dispatchViewMessage.textColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
        dispatchViewMessage.setLineHeight(3, alignment: .Center)
        policeLabel.textColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
        ambulanceLabel.textColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
        fireLabel.textColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
        
        policeSwitch.on = false
        policeSwitch.addTarget(self, action: #selector(enableButton), forControlEvents: .TouchUpInside)
        policeSwitch.tag = 0
        
        ambulanceSwitch.on = false
        ambulanceSwitch.addTarget(self, action: #selector(enableButton), forControlEvents: .TouchUpInside)
        ambulanceSwitch.tag = 1
        fireSwitch.on = false
        fireSwitch.addTarget(self, action: #selector(enableButton), forControlEvents: .TouchUpInside)
        fireSwitch.tag = 2
        
        services.append(policeSwitch); services.append(ambulanceSwitch); services.append(fireSwitch)
        dispatchButton.enabled = false
    }
    
    class func instanceFromNib() -> DispatchMenuView {
        return UINib(nibName: "dispatchMenuViewNib", bundle: nil).instantiateWithOwner(nil, options: nil).first as! DispatchMenuView
    }
    
    func showInView(mainView: UIView!, animated: Bool) {
        shadow.frame = UIScreen.mainScreen().bounds
        shadow.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)

        shadow.addSubview(self)
        mainView.addSubview(shadow)
        self.center = shadow.center
        
        if let callback = onPopUpOpen {
        callback ()
        }
        
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
                if (finished)
                {
                    self.removeFromSuperview()
                    
                }
        });
    }

    func enableButton(sender: UISwitch) {
        
        if sender.on {
            enabledServicesCount+=1
        } else {
            enabledServicesCount-=1
        }
        
        if enabledServicesCount >= 1 {
            dispatchButton.enabled = true
            dispatchButton.backgroundColor = UIColor(red: 23/255, green: 120/255, blue: 61/255, alpha: 1.0)
            dispatchButton.setTitleColor(.whiteColor(), forState: .Normal)
        } else {
            dispatchButton.enabled = false
            dispatchButton.backgroundColor = .lightGrayColor()
            dispatchButton.setTitleColor(.darkGrayColor(), forState: .Normal)
        }
    }
    
    
    @IBAction func closeDispatchView(sender: AnyObject) {
        self.removeAnimate()
        if let resume = resume {
            resume()
        }
        if let callback = onPopUpClose {
            callback ()
        }
    }
    

    
    @IBAction func sendDispatch(sender: AnyObject) {

        let filteredServces = services.filter { (service) -> Bool in
            return service.on
        }
        
        for _ in filteredServces {
        }
        
    }
}