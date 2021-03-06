//
//  EventView.swift
//  TheOperator
//
//  Created by Daniel Robertson on 22/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class EventView: UIView {
    @IBOutlet weak var headlineLabel: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let nibsView = NSBundle.mainBundle().loadNibNamed("eventViewNib", owner: self, options: nil) as? [UIView] {
            let nibRoot = nibsView[0]
            self.addSubview(nibRoot)
            nibRoot.frame = self.bounds
        }
    }

//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
    override func awakeFromNib() {
        super.awakeFromNib()
        headlineLabel.textColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
       
    }
//
//    class func instanceFromNib() -> EventView {
//        return UINib(nibName: "eventViewNib", bundle: nil).instantiateWithOwner(nil, options: nil).first as! EventView
//    }
//    
//    func showInView(mainView: UIView!, animated: Bool) {
//        mainView.addSubview(self)
//        
//        if animated {
//            self.showAnimate()
//        }
//    }
//    
//    func showAnimate() {
//        self.transform = CGAffineTransformMakeScale(1.3, 1.3)
//        self.alpha = 0
//
//        UIView.animateWithDuration(0.25, animations: {
//            self.alpha = 1.0
//            self.transform = CGAffineTransformMakeScale(1.0, 1.0)
//        });
//    }


}
