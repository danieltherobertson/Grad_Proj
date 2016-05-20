//
//  LevelReviewViewController.swift
//  TheOperator
//
//  Created by Daniel Robertson on 18/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class LevelReviewViewController: UIViewController, NSLayoutManagerDelegate{

    @IBOutlet weak var reviewTitle: UILabel!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var reviewRank: UILabel!
    @IBOutlet weak var reviewChief: CenteredLabel!
    @IBOutlet weak var reviewFeedback: CenteredLabel!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var label_1: UILabel!
    @IBOutlet weak var label_1a: UILabel!
    @IBOutlet weak var label_2: UILabel!
    @IBOutlet weak var label_2a: UILabel!
    @IBOutlet weak var label_3: UILabel!
    @IBOutlet weak var label_3a: UILabel!
    @IBOutlet weak var label_4: UILabel!
    @IBOutlet weak var label_4a: UILabel!
    
    let review_1 = "Remaining Time:"
    let review_1a = "00:27"
    let review_2 = "Reported Issue:"
    let review_2a = "Grand Theft Auto"
    let review_3 = "Dispatched Units:"
    let review_3a = "Police"
    let review_4 = "Suggested Dispatch:"
    let review_4a = "Police, Ambulance"
    
    var reviewTexts = [String]()
    var reviewLabels = [UILabel]()
    var activeLine = Int()
    
    var rank = String()
    var comment = String()

    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
                reviewTitle.setLineHeight(3, alignment: .Center)
       
        //reviewRank.setLineHeight(3, alignment: .Center)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        timeToInt("07:08")
        continueButton.buttonStyle(continueButton)
        
        reviewTexts = [review_1,review_1a,review_2,review_2a,review_3,review_3a,review_4,review_4a]
        reviewLabels = [label_1,label_1a,label_2,label_2a,label_3,label_3a,label_4,label_4a]
        
        var activeLine = 0

        reviewRank.setLineHeight(3, alignment: .Left)
        rank = "Rewarded Rank: Recruit"
        comment = "Is that the best you can do? I expected better from you."

        type()
        // Do any additional setup after loading the view.
    }
    
    func type() {
        
        var inUseLabel = UILabel()
        var inUseString = ""
        
        for (index, label) in reviewLabels.enumerate() {
            if index == activeLine {
                inUseLabel = label
            }
        }
        
        for (index, string) in reviewTexts.enumerate() {
            if index == activeLine {
                inUseString = string
            }
        }
        
        inUseLabel.typeStart(inUseString)
        onTypeComplete = {
            self.activeLine += 1
            if self.activeLine >= self.reviewTexts.count {
                delay(0.5, closure: { 
                    self.reviewRank.typeStart(self.rank)
                    onTypeComplete = {
                        delay(0.5, closure: { 
                            self.reviewChief.typeStart("Cheif's comments:")
                            onTypeComplete = {
                                delay(0.5, closure: { 
                                    self.reviewFeedback.typeStart(self.comment)
                                    onTypeComplete = {
                                        
                                    }
                                })
                            }
                        })
                   }
                })
            }
            else {
                delay(0.5, closure: {
                    self.type()
                })
            }
        }
    }
    
    func layoutManager(layoutManager: NSLayoutManager, lineSpacingAfterGlyphAtIndex glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
