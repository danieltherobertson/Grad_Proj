//
//  GameView.swift
//  menuTest
//
//  Created by Daniel Robertson on 16/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class GameView: UIView {

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var gameText: UILabel!
    @IBOutlet weak var gameAnswerOne: UIButton!
    @IBOutlet weak var gameAnswerTwo: UIButton!
    @IBOutlet weak var gameAnswerThree: UIButton!
    @IBOutlet weak var gameAnswerFour: UIButton!
    @IBOutlet weak var gameAnswerFive: UIButton!
    @IBOutlet weak var gameAnswerSix: UIButton!
    @IBOutlet weak var labelHeightConstraint: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let nib = UINib(nibName: "gameViewNib", bundle: nil)
        if let contentView = nib.instantiateWithOwner(self, options: nil).first as? UIView {
            self.addSubview(contentView)
            
            gameAnswerOne.buttonStyle(gameAnswerOne)
            gameAnswerTwo.buttonStyle(gameAnswerTwo)
            gameAnswerThree.buttonStyle(gameAnswerThree)
            gameAnswerOne.buttonStyle(gameAnswerFour)
            gameAnswerTwo.buttonStyle(gameAnswerFive)
            gameAnswerThree.buttonStyle(gameAnswerSix)
            gameText.clipsToBounds = true
            gameText.labelStyle(gameText)
            
            labelHeightConstraint.constant = 0
        }
    }
}
