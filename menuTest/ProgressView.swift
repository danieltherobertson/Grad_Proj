//
//  ProgressView.swift
//  menuTest
//
//  Created by Daniel Robertson on 19/03/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit
class ProgressView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var levelsView: UICollectionView!
    var tagID: Int!
    var gameSaves = Array<GameSave>()
    var viewedSave: GameSave!
    var levelsData: [NSDictionary]!
    var toInt:Int?
    
    override func layoutSubviews() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 100)
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 30
        
        
        levelsView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        // gamesView.translatesAutoresizingMaskIntoConstraints = false
        levelsView.dataSource = self
        levelsView.delegate = self
        
        let nib:UINib = UINib(nibName: "gameProgressNib", bundle: nil)
        levelsView.registerNib(nib, forCellWithReuseIdentifier: "progressCell")
        
        self.addSubview(levelsView)
    }
    //-----------------INITIALISING THE COLLECTION VIEW INSIDE THE UIVIEW ----------------------------------------------
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Load any existing gameSave types from gameSaves
        
        
    }
    
    //-----------------NUMBER OF CELLS----------------------------------------------
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levelsData!.count
    }
    
    //-----------------ADDS DATA TO THE CELLS, OR DRAWS THEM AS EMPTY----------------------------------------------
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("progressCell", forIndexPath: indexPath) as! progressCell
        let playerProgress = viewedSave.progress
            //Get saved games and populate cells
            if indexPath.row < levelsData!.count {
                let gameSlot = levelsData![indexPath.row]
                let levelName = gameSlot.valueForKey("name")!
                cell.levelName.text = levelName as? String
                let levelNumber = gameSlot.valueForKey("number")!
                toInt = Int(levelNumber as! String)
                let intAdd = toInt!+1
                let toString = String(intAdd)

                cell.levelNumber.text = toString
                if indexPath.row < playerProgress {
                    cell.userInteractionEnabled = false
                    cell.layer.borderWidth = 0
                    cell.levelImage.image = UIImage(named: "tick")
                    cell.levelStatus = LevelStatus.Completed
                
                } else if indexPath.row == playerProgress {
                    cell.layer.borderWidth = 2.0
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.levelImage.image = nil
                    cell.userInteractionEnabled = true
                    cell.levelStatus = LevelStatus.Current
                    
                } else if indexPath.row > playerProgress {
                    cell.levelImage.image = UIImage(named: "padlock")
                    cell.layer.borderWidth = 2
                    cell.layer.borderColor = UIColor.redColor().CGColor
                    cell.userInteractionEnabled = false
                    cell.levelStatus = LevelStatus.Locked
                }
                cell.levelName.textColor = UIColor.blackColor()
                cell.levelNumber.textColor = UIColor.blackColor()
                cell.tag = toInt!
                print (cell.tag)

                //Unpopulated cells are drawn like...
            } else {
                cell.levelName.textColor = UIColor.blackColor()
                cell.levelNumber.textColor = UIColor.blackColor()
                cell.levelName.text = "[Empty]"
                cell.levelNumber.text = "[Empty]"
//                cell.tag = 1
                // cell.inUse = false
                // notInUse.append(cell)
            }
        
        // Configure the cell
        return cell
    }
    //-----------------SETTING A CELL'S SIZE----------------------------------------------
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 140)
    }
    
    //-----------------HANDLES THE 4 SCENARIOS FOR TAPPING COLLECTION VIEW CELLS----------------------------------------------
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let activeCell = collectionView.cellForItemAtIndexPath(indexPath)
        
        // print("notInUse capacity:\(notInUse.capacity)")
        // print("inUseCells capactiy\(inUseCells.capacity)")
        
        
        func viewReset(alertAction: UIAlertAction) {
            activeCell?.layer.borderWidth = 0
            activeCell?.layer.borderColor = nil
            activeCell?.backgroundColor = UIColor.greenColor()
            collectionView.userInteractionEnabled = true
        }
        
        func reset() {
            activeCell?.layer.borderWidth = 0
            activeCell?.layer.borderColor = nil
            activeCell?.backgroundColor = UIColor.greenColor()
            collectionView.userInteractionEnabled = true
        }
        

        
        
    }
    //-----------------HANDLES DESELECTING CELLS IN THE COLLECTION VIEW----------------------------------------------
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        let activeCell = collectionView.cellForItemAtIndexPath(indexPath)
        
        activeCell?.layer.borderWidth = 0
        activeCell?.layer.borderColor = nil
        
        collectionView.reloadItemsAtIndexPaths([indexPath])
    }
        //-----------------LOADS THE GAMESAVE ARRAY----------------------------------------------
    func loadLevels(levels: [NSDictionary]) {
        levelsData = levels
        
       // print("printing levelss \(levelsData)")
    }  
}
