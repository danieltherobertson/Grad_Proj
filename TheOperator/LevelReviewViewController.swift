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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
                reviewTitle.setLineHeight(3, alignment: .Center)
       
        //reviewRank.setLineHeight(3, alignment: .Center)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewText.editable = true
        reviewText.text = ""
        reviewText.setLineHeight(3, alignment: .Left)
        reviewText.backgroundColor = UIColor.blackColor()
        reviewText.font = UIFont(name: "KemcoPixelBold", size: 16)
        reviewText.textColor = UIColor(red:0.00, green:0.86, blue:0.00, alpha:1.0)
        reviewRank.setLineHeight(3, alignment: .Left)
        reviewText.layoutManager.delegate = self
        reviewText.editable = false
        
        let feedback = "Remaining Time: \n\n00:27 \n \n \nReported Issue: \n\nGrand Theft Auto \n \n \nDispatched Units: \n\nPolice \n \n\nRecommended Dispatch Action: \n\nPolice, Ambulance"
        let rank = "Rewarded Rank: Recruit"
        reviewText.typeStart(feedback)
       // reviewText.setLineHeight(3, alignment: .Left)
        onTypeComplete = {
            self.reviewRank.typeStart(rank)
            onTypeComplete = {
                print("doot")
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
