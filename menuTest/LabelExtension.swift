
//
//  LabelExtension.swift
//  menuTest
//
//  Created by Daniel Robertson on 14/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            style.alignment = .Center
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, text.characters.count))
            self.attributedText = attributeString
        }
    }
    
    func typeStart(dialogue: String) {
        let text = dialogue
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.09, target: self, selector: #selector(addNextLetter(_:)), userInfo: text, repeats: true)
        timer.fire()
    }
    
    func addNextLetter(timer: NSTimer) {
        
        let dialogue = timer.userInfo as! String
        print(text)
        
        let textArray = Array(dialogue.characters)
        
        
        if self.text!.characters.count >= textArray.count {
            timer.invalidate()
            
        } else {
            let nextLetterIndex = self.text!.characters.count
            let character = textArray[nextLetterIndex]
            self.text = text! + String(character)
            print(text)
        }
    }
    
}