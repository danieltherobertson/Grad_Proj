//
//  gameCell.swift
//  TheOperator
//
//  Created by Daniel Robertson on 18/02/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class gameCell: UICollectionViewCell {
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameLevel: UILabel!
    var inUse: Bool!
}
