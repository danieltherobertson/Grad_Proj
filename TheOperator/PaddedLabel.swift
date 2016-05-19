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
        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        setLineHeight(3, alignment: .Left)
        
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}

class CenteredLabel: UILabel {
    override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        setLineHeight(3, alignment: .Center)
        
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
    
}

class PaddedTextView: UITextView {
    func layoutManagerD(layoutManager: NSLayoutManager, lineSpacingAfterGlyphAtIndex glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return 3
    }
}

