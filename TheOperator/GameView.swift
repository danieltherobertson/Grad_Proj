//
//  GameView.swift
//  TheOperator
//
//  Created by Daniel Robertson on 16/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class GameView: UIView, NSLayoutManagerDelegate {

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var levelIndicator: UILabel!
    @IBOutlet weak var timeIndicator: UILabel!
   // @IBOutlet weak var gameText: UILabel!
    @IBOutlet weak var gameTextContainer: UIView!
    @IBOutlet weak var gameTextContainerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var gameText: UITextView!
  //  @IBOutlet weak var speakerView: UITextView!
    @IBOutlet weak var speakerName: UILabel!
    
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var characterImg: UIImageView!
    
    @IBOutlet weak var gameAnswerOne: UIButton!
    @IBOutlet weak var gameAnswerTwo: UIButton!
    @IBOutlet weak var gameAnswerThree: UIButton!
    
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var dispatchButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var introLabel: UILabel!

    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
 //   @IBOutlet weak var speakerViewHeightConstraint: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let nib = UINib(nibName: "gameViewNib", bundle: nil)
        if let contentView = nib.instantiateWithOwner(self, options: nil).first as? UIView {
            self.addSubview(contentView)
            
            dispatchButton.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
            dispatchButton.layer.borderWidth = 4
            
            //dispatchButton.buttonStyle(dispatchButton, colour: .JuicyDark)
         //   dispatchButton.layer.addBorder(.Right, color: UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1), thickness: 4)
//            dispatchButton.layer.addBorder(.Top, color: UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1), thickness: 4)
//            dispatchButton.layer.addBorder(.Left, color: UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1), thickness: 4)
//            dispatchButton.layer.addBorder(.Right, color: UIColor(red: 25/255, green: 165/255, blue: 38/2555, alpha: 1), thickness: 4)

            
            gameTextContainer.layer.cornerRadius = 20
            gameTextContainer.layer.borderWidth = 4
            gameTextContainer.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
            
           //bottomBar.layer.addBorder(.Top, color: UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1), thickness: 4)
            
            gameAnswerOne.buttonStyle(gameAnswerOne)
            gameAnswerTwo.buttonStyle(gameAnswerTwo)
            gameAnswerThree.buttonStyle(gameAnswerThree)
            skipButton.buttonStyle(skipButton)
            gameText.clipsToBounds = true
            //gameText.textFieldStyle(gameText)
            introLabel.setLineHeight(30, alignment: .Center)
            //textViewHeightConstraint.constant = 0
            gameTextContainerHeightConstraint.constant = 0
           // gameText.textContainerInset = UIEdgeInsets(top: 200, left: 20, bottom: 0, right: 20)
            gameText.editable = true
            gameText.font = UIFont(name: "KemcoPixelBold", size: 14)
            speakerName.font = UIFont(name: "KemcoPixelBold", size: 16)
            //gameText.backgroundColor = UIColor(red: 0/255, green: 220/255, blue: 0/255, alpha: 1.0)
            gameText.layoutManager.delegate = self
            let gameTextWidth = gameText.frame.width
            let gameTextHeight = gameText.frame.height
           // let imgRect = UIBezierPath(rect: CGRectMake(5, 5, 50, 80))
           // gameText.textContainer.exclusionPaths = [imgRect]
            gameText.editable = false
            gameText.selectable = false
            
            
        }
    }
    
   func layoutManager(layoutManager: NSLayoutManager, lineSpacingAfterGlyphAtIndex glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return 3
    }
}
