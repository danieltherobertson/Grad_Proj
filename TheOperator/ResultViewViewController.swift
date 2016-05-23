//
//  ResultViewViewController.swift
//  TheOperator
//
//  Created by Daniel Robertson on 23/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class ResultViewViewController: UIViewController {
    


    @IBOutlet weak var sirensGif: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    let gif = UIImage.gifWithName("operator")


    override func viewDidLoad() {
        super.viewDidLoad()
        sirensGif.image = gif
        sirensGif.alpha = 0
        sirensGif.transform = CGAffineTransformMakeScale(1.3, 1.3)
        containerView.alpha = 0
        self.containerView.transform = CGAffineTransformMakeScale(1.3, 1.3)
        let triggerTime = Int64(2 * (NSEC_PER_SEC))
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), {
            UIView.animateWithDuration(0.50, animations: { 
                self.sirensGif.alpha = 1.0
                self.sirensGif.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: { (true) in
                    let triggerTime = Int64(3 * (NSEC_PER_SEC))
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), {
                        self.sirensGif.alpha = 0
                        UIView.animateWithDuration(0.50, animations: {
                            self.containerView.alpha = 1.0
                            self.containerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                        });
                    })
            })
        })
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
