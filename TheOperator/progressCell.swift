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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        levelName.setLineHeight(3, alignment: .Left)
    }
    
    func styleSelected(tag:Int) {
        switch tag {
        case 0:
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.cyanColor().CGColor
        case 1:
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.whiteColor().CGColor
        case 2:
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.redColor().CGColor
        default:
            break
        }
    }
}

enum LevelStatus: String {
    case Completed = "Completed"
    case Current = "Current"
    case Locked = "Locked"
}
