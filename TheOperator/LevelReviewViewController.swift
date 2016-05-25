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
    //@IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var reviewRank: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var label_1: UILabel!
    @IBOutlet weak var label_1a: UILabel!
    @IBOutlet weak var label_2: UILabel!
    @IBOutlet weak var label_2a: UILabel!
    @IBOutlet weak var label_3: UILabel!
    @IBOutlet weak var label_3a: UILabel!
    @IBOutlet weak var label_4: UILabel!
    @IBOutlet weak var label_4a: SpacingLabel!
    @IBOutlet weak var label_5: UILabel!
    @IBOutlet weak var label_5a: LeftLabel!

    
    var requiredServices = String()
    
    let review_1 = "Remaining Time:"
    var review_1a = String()
    let review_2 = "Reported Issue:"
    var review_2a = String()
    let review_3 = "Dispatched Units:"
    var review_3a = String()
    let review_4 = "Suggested Dispatch:"
    var review_4a = String()
    let review_5 = "Level Passed?"
    
    var reviewTexts = [String]()
    var reviewLabels = [UILabel]()
    var activeLine = Int()
    var rank = String()
    var comment = String()
    var specialPoints = Int()
    var availableSpecialPoints = Int()
    var levelPassed = Bool()
    var passedString = String()
    var activeSave: GameSave!
    var playerRank = String()
    
    var requiredServicesArray = [String]()
    var startingTime = Int()

    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
                reviewTitle.setLineHeight(3, alignment: .Center)
       
        //reviewRank.setLineHeight(3, alignment: .Center)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.addTarget(self, action: #selector(segueToProgressView), forControlEvents: .TouchUpInside)
        continueButton.enabled = false
         continueButton.buttonStyle(continueButton)
        continueButton.backgroundColor = .lightGrayColor()
        continueButton.layer.borderColor = UIColor.darkGrayColor().CGColor
        let servicesInt = servicesStringToInt(review_3a)
        playerRank = calculateRank(startingTime, remainingTime: review_1a, dispatchedServices: servicesInt, requiredServices: requiredServicesArray, availablePoints: availableSpecialPoints, points: specialPoints, passed: levelPassed)
       
        
        if levelPassed {
            passedString = "Yes, congratulations!"
        } else {
            passedString = "No, you've failed!"
            label_5a.textColor = .redColor()
        }
        
        reviewTexts = [review_1,review_1a,review_2,review_2a,review_3,review_3a,review_4,review_4a]
        reviewLabels = [label_1,label_1a,label_2,label_2a,label_3,label_3a,label_4,label_4a]
        
        activeLine = 0

        reviewRank.setLineHeight(3, alignment: .Left)
        rank = "Rewarded Rank: \(playerRank)"
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
                    self.label_5.typeStart(self.review_5)
                    onTypeComplete = {
                        self.label_5a.typeStart(self.passedString)
                        onTypeComplete = {
                            self.reviewRank.typeStart(self.rank)
                            onTypeComplete = {
                                self.continueButton.enabled = true
                                self.continueButton.backgroundColor = UIColor(red: 0/255, green: 220/255, blue: 0/255, alpha: 1.0)
                                self.continueButton.buttonStyle(self.continueButton)
                            }
                        }
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
    
    func segueToProgressView() {
        performSegueWithIdentifier("levelReviewToProgressView", sender: self)
    }

   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let progressVC = (segue.destinationViewController as? ProgressViewController)
        
        
        if segue.identifier == "levelReviewToProgressView" {
            if levelPassed {
                activeSave.progress!+=1
                activeSave.rankings.append(playerRank)
            }
            progressVC?.currentSave = activeSave
            overwriteGame(activeSave)
        }
    }
    

}
