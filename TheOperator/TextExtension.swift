
//
//  LabelExtension.swift
//  TheOperator
//
//  Created by Daniel Robertson on 14/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation
import UIKit

var onTypeComplete: (() -> Void)!
var typeSpeed = 0.05

extension UILabel {

    func setLineHeight(lineHeight: CGFloat, alignment: NSTextAlignment) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            style.alignment = alignment
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, text.characters.count))
            self.attributedText = attributeString
        }
    }
    
    func labelStyle(label: UILabel) -> UILabel {
        
        let label = label
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 4
        label.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
        
        return label
    }
    
    func typeStart(dialogue: String) {
        let text = dialogue
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(addNextLetter(_:)), userInfo: text, repeats: true)
        timer.fire()
    }
    
    func addNextLetter(timer: NSTimer) {
        
        let dialogue = timer.userInfo as! String
        
        let textArray = Array(dialogue.characters)
        
        if self.text!.characters.count >= textArray.count {
            timer.invalidate()
            
            if let callback = onTypeComplete {
                callback ()
            }
        } else {
            let nextLetterIndex = self.text!.characters.count
            let character = textArray[nextLetterIndex]
            self.text = text! + String(character)
        }
    }
}

extension UITextView {
    
    
    func setLineHeight(lineHeight: CGFloat, alignment: NSTextAlignment) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            style.alignment = alignment
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, text.characters.count))
            self.attributedText = attributeString
        }
    }
    
    func textFieldStyle(textView: UITextView) -> UITextView {
        
        let tView = textView
        tView.layer.cornerRadius = 20
        tView.layer.borderWidth = 4
        tView.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
        tView.setLineHeight(30, alignment: .Left)
        
        return tView
    }
    
    func typeStart(dialogue: String) {
        let text = dialogue
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(typeSpeed, target: self, selector: #selector(addNextLetter(_:)), userInfo: text, repeats: true)
        timer.fire()
    }
    
    func addNextLetter(timer: NSTimer) {
        
        let dialogue = timer.userInfo as! String
        
        let textArray = Array(dialogue.characters)
        
        if self.text!.characters.count >= textArray.count {
            timer.invalidate()
            typeSpeed = 0.05
            if let callback = onTypeComplete {
                callback ()
            }
        } else if typeSpeed == 0.01 {
            self.text = dialogue
            timer.invalidate()
            typeSpeed = 0.05
            if let callback = onTypeComplete {
                callback ()
            }

        } else {
            let nextLetterIndex = self.text!.characters.count
            let character = textArray[nextLetterIndex]
            self.text = text! + String(character)
            
            let range = NSMakeRange(self.text!.characters.count - 1, 1);
            self.scrollRangeToVisible(range)
        }
    }

}