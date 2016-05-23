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
    @IBOutlet weak var incomingNews: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    let gif = UIImage.gifWithName("operator")


    override func viewDidLoad() {
        super.viewDidLoad()
        incomingNews.setLineHeight(3, alignment: .Center)
        incomingNews.alpha = 0
        continueButton.alpha = 0
        sirensGif.image = gif
        sirensGif.alpha = 0
        sirensGif.transform = CGAffineTransformMakeScale(3.3, 3.3)
        containerView.alpha = 0
        self.containerView.transform = CGAffineTransformMakeScale(1.3, 1.3)
        let triggerTime = Int64(2 * (NSEC_PER_SEC))
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), {
            UIView.animateWithDuration(0.50, animations: { 
                self.sirensGif.alpha = 1.0
                self.incomingNews.alpha = 1.0
                self.incomingNews.blink(0.2)
                self.sirensGif.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: { (true) in
                    let triggerTime = Int64(3 * (NSEC_PER_SEC))
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), {
                        self.sirensGif.alpha = 0
                        UIView.animateWithDuration(0.5, animations: {
                            self.incomingNews.stopAnimation()
                            self.containerView.alpha = 1.0
                            self.containerView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                            self.continueButton.alpha = 1.0
                         }, completion: { (true) in
                                UIView.animateWithDuration(0.095, animations: {
                                    self.containerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                            })
                        })
                    })
            })
        })
    }

    @IBAction func segueToReviewScreen(sender: AnyObject) {
        performSegueWithIdentifier("resultsToReviewScreen", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let reviewVC = (segue.destinationViewController as? LevelReviewViewController)

    }


}
