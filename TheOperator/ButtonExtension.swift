//
//  ButtonExtension.swift
//  TheOperator
//
//  Created by Daniel Robertson on 21/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func buttonStyle(button: UIButton, colour: ButtonColour = .Green) -> UIButton {
        
        let button = button
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 4
        button.layer.borderColor = colour.color.CGColor
        return button
    }
    
    func gameButtonStyle(button: UIButton, colour: ButtonColour = .Green) -> UIButton {
        
        let button = button
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 4
        button.layer.borderColor = colour.color.CGColor
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.titleLabel?.setLineHeight(2.5, alignment: .Left)
        return button
    }
    
    func buttonStyleInset(button: UIButton, colour: ButtonColour = .Green) -> UIButton {
        
        let button = button
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 4
        button.layer.borderColor = colour.color.CGColor
        button.contentEdgeInsets = UIEdgeInsetsMake(7,0,0,0)
        return button
    }

}

enum ButtonColour {
    case Red
    case Green
    case White
    case JuicyDark
    case PauseRed
    
    var color: UIColor {
        get {
            switch self {
            case .Green: return UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1)
            case .Red: return UIColor(red: 190/255, green: 0/255, blue: 0/255, alpha: 1)
            case .White: return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            case .JuicyDark: return UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
            case .PauseRed: return UIColor(red:1.00, green:0.23, blue:0.24, alpha:1.0)

            }
        }
    }
}