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
    func buttonStyle(button: UIButton) -> UIButton {
        
        let button = button
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
        
        return button
    }
}