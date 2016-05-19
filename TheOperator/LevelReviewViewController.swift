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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
                reviewTitle.setLineHeight(3, alignment: .Center)
       
        //reviewRank.setLineHeight(3, alignment: .Center)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewText.editable = true
        reviewText.text = ""
        reviewText.backgroundColor = UIColor.blackColor()
        reviewText.font = UIFont(name: "KemcoPixelBold", size: 16)
        reviewText.textColor = UIColor(red:0.00, green:0.86, blue:0.00, alpha:1.0)
        reviewRank.setLineHeight(3, alignment: .Left)
        reviewText.layoutManager.delegate = self
        reviewText.editable = false
        reviewText.selectable = false
        
        
       
        
        let feedback = "Remaining Time: \r 00:27 \r \r \rReported Issue: \r Grand Theft Auto \r \r \r Dispatched Units: \r Police \r \r \r Recommended Dispatch Action: \r Police, Ambulance"
        let rank = "Rewarded Rank: Recruit"
        let comment = "Is that the best you can do? I expected better from you."
        reviewText.typeStart(feedback)

       // reviewText.setLineHeight(3, alignment: .Left)
        onTypeComplete = {
            self.reviewRank.typeStart(rank)
            onTypeComplete = {
                self.reviewChief.typeStart("Cheif's comments:")
                onTypeComplete = {
                    self.reviewFeedback.typeStart(comment)
                    onTypeComplete = {
                        
                    }
                }
            }
        }
        
        
    

        // Do any additional setup after loading the view.
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
