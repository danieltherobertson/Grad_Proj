//
//  progressCell.swift
//  TheOperator
//
//  Created by Daniel Robertson on 07/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class progressCell: UICollectionViewCell {
    @IBOutlet weak var levelName: UILabel!
    @IBOutlet weak var levelNumber: UILabel!
    @IBOutlet weak var levelImage: UIImageView!
    var levelStatus: LevelStatus!
}

enum LevelStatus: String {
    case Completed = "Completed"
    case Current = "Current"
    case Locked = "Locked"
}
