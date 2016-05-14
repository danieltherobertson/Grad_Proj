//
//  ServiceEnum.swift
//  TheOperator
//
//  Created by Daniel Robertson on 14/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation
import UIKit


    

enum Service {
    case Police
    case Ambulance
    case Fire
    
    var service: String {
        get {
            switch  self {
            case .Police: return "Police"
            case .Ambulance: return "Ambulance"
            case .Fire: return "Fire"
            }
        }
    }
            
            

    
}
