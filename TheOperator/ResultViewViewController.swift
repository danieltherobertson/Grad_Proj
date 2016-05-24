//
//  ResultViewViewController.swift
//  TheOperator
//
//  Created by Daniel Robertson on 23/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class ResultViewViewController: UIViewController {
    

    var headline = String()
    @IBOutlet weak var eventView: EventView!
    @IBOutlet weak var incomingNews: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    let gif = UIImage.gifWithName("operator")


    override func viewDidLoad() {
        super.viewDidLoad()
        eventView.headlineLabel.text = headline
        eventView.headlineLabel.adjustsFontSizeToFitWidth = true
        incomingNews.setLineHeight(3, alignment: .Center)
        incomingNews.alpha = 0
        continueButton.alpha = 0
        continueButton.enabled = false
        eventView.alpha = 0
        self.eventView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        let triggerTime = Int64(2 * (NSEC_PER_SEC))
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), {
            UIView.animateWithDuration(0.50, animations: {
                self.incomingNews.alpha = 1.0
                self.incomingNews.blink(0.2)
                }, completion: { (true) in
                    let triggerTime = Int64(3 * (NSEC_PER_SEC))
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), {
                        UIView.animateWithDuration(0.8, animations: {
                            self.incomingNews.stopAnimation()
                            self.eventView.alpha = 1.0
                            self.eventView.transform = CGAffineTransformMakeScale(1.1, 1.1)
                            self.continueButton.alpha = 1.0
                         }, completion: { (true) in
                                UIView.animateWithDuration(0.2, animations: {
                                    self.eventView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                                    self.continueButton.alpha = 1.0
                                    self.continueButton.enabled = true
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
