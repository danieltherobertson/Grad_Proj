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
    
    @IBOutlet weak var levelCompleted: UILabel!
    
    @IBOutlet weak var levelRank: UILabel!
    
    @IBOutlet weak var levelImage: UIImageView!
    var levelStatus: LevelStatus!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        levelName.setLineHeight(3, alignment: .Left)
        levelRank.textColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
        levelRank.setLineHeight(3, alignment: .Left)
        levelCompleted.textColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
    }
    
    func styleSelected(tag:Int) {
        switch tag {
        case 0:
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.whiteColor().CGColor
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
