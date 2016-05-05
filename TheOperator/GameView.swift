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
    @IBOutlet weak var gameText: UITextView!
    
    @IBOutlet weak var characterImg: UIImageView!
    
    @IBOutlet weak var gameAnswerOne: UIButton!
    @IBOutlet weak var gameAnswerTwo: UIButton!
    @IBOutlet weak var gameAnswerThree: UIButton!
    
    @IBOutlet weak var introLabel: UILabel!

    

    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let nib = UINib(nibName: "gameViewNib", bundle: nil)
        if let contentView = nib.instantiateWithOwner(self, options: nil).first as? UIView {
            self.addSubview(contentView)
            
            gameAnswerOne.buttonStyle(gameAnswerOne)
            gameAnswerTwo.buttonStyle(gameAnswerTwo)
            gameAnswerThree.buttonStyle(gameAnswerThree)
            gameText.clipsToBounds = true
            gameText.textFieldStyle(gameText)
            introLabel.setLineHeight(30, alignment: .Center)
            textViewHeightConstraint.constant = 0
            gameText.textContainerInset = UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
            gameText.editable = true
            gameText.font = UIFont(name: "KemcoPixelBold", size: 14)
            gameText.backgroundColor = .greenColor()
            gameText.layoutManager.delegate = self
            let imgRect = UIBezierPath(rect: CGRectMake(5, 5, 50, 70))
            gameText.textContainer.exclusionPaths = [imgRect]
            gameText.editable = false
            
            
        }
    }
    
   func layoutManager(layoutManager: NSLayoutManager, lineSpacingAfterGlyphAtIndex glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return 3
    }
}
