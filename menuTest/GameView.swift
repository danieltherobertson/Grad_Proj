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
    @IBOutlet weak var gameText: UITextView!
    @IBOutlet weak var gameAnswerOne: UIButton!
    @IBOutlet weak var gameAnswerTwo: UIButton!
    @IBOutlet weak var gameAnswerThree: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let nib = UINib(nibName: "gameViewNib", bundle: nil)
        if let contentView = nib.instantiateWithOwner(self, options: nil).first as? UIView {
            self.addSubview(contentView)
        }
    }

}
