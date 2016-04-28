//
//  PaddedLabel.swift
//  TheOperator
//
//  Created by Daniel Robertson on 01/02/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {
    override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        setLineHeight(3, alignment: .Left)
        
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}
