//
//  PaddedLabel.swift
//  menuTest
//
//  Created by Daniel Robertson on 01/02/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {
    override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsets(top: -55, left: 10, bottom: 0, right: 0)
        
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}
