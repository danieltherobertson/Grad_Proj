//
//  GameView.swift
//  TheOperator
//
//  Created by Daniel Robertson on 16/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class GameView: UIView {

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var levelIndicator: UILabel!
    @IBOutlet weak var timeIndicator: UILabel!
    @IBOutlet weak var gameText: UILabel!
    @IBOutlet weak var gameAnswerOne: UIButton!
    @IBOutlet weak var gameAnswerTwo: UIButton!
    @IBOutlet weak var gameAnswerThree: UIButton!
    @IBOutlet weak var singleButton: UIButton!
    
    @IBOutlet weak var introLabel: UILabel!

    @IBOutlet weak var labelHeightConstraint: NSLayoutConstraint!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let nib = UINib(nibName: "gameViewNib", bundle: nil)
        if let contentView = nib.instantiateWithOwner(self, options: nil).first as? UIView {
            self.addSubview(contentView)
            
            gameAnswerOne.buttonStyle(gameAnswerOne)
            gameAnswerTwo.buttonStyle(gameAnswerTwo)
            gameAnswerThree.buttonStyle(gameAnswerThree)
            singleButton.buttonStyle(singleButton)
            gameText.clipsToBounds = true
            gameText.labelStyle(gameText)
            introLabel.setLineHeight(30, alignment: .Center)
            labelHeightConstraint.constant = 0
        }
    }
}
