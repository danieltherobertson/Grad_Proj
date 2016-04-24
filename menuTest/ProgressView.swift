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
    var viewedSave: GameSave!
    var levelsData: [NSDictionary]!
    var toInt:Int?
    var toString:String?
    var currentGameSelected: ((level: Int) -> ())!
    
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
                toString = String(intAdd)
                cell.levelNumber.text = toString
                
                if indexPath.row < playerProgress {
                   // cell.userInteractionEnabled = false
                    cell.levelImage.image = UIImage(named: "tick")
                    cell.levelStatus = LevelStatus.Completed
                    cell.tag = 0
                
                } else if indexPath.row == playerProgress {
                    cell.levelImage.image = nil
                    cell.userInteractionEnabled = true
                    cell.levelStatus = LevelStatus.Current
                    cell.tag = 1
                    
                } else if indexPath.row > playerProgress {
                    cell.levelImage.image = UIImage(named: "padlock")
                   // cell.userInteractionEnabled = false
                    cell.levelStatus = LevelStatus.Locked
                    cell.tag = 2
                }
                cell.levelName.textColor = UIColor.blackColor()
                cell.levelNumber.textColor = UIColor.blackColor()
                //cell.tag = toInt!
               // print (cell.tag)

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

        func reset() {
            activeCell?.layer.borderWidth = 0
            activeCell?.layer.borderColor = nil
            activeCell?.backgroundColor = UIColor.greenColor()
            collectionView.userInteractionEnabled = true
        }
        
        if activeCell?.tag == 0 {
            
            activeCell?.layer.borderWidth = 3.0
            activeCell?.layer.borderColor = UIColor.cyanColor().CGColor
            
                let currentCellPos = indexPath.row
                self.currentGameSelected(level: currentCellPos)


        }
        
        if activeCell?.tag == 1 {
            
            activeCell?.layer.borderWidth = 3.0
            activeCell?.layer.borderColor = UIColor.whiteColor().CGColor
            
//            let dialogue = ZAlertView(title: "Error", message: "No save file detected. Please select a different slot.", closeButtonText: "Okay", closeButtonHandler: { alertView in
//                reset()
//                alertView.dismiss()
//            })
//            dialogue.allowTouchOutsideToDismiss = false
//            dialogue.show()
            let currentCellPos = indexPath.row
            currentGameSelected(level: currentCellPos)

        }
        
        if activeCell?.tag == 2 {
            
            activeCell?.layer.borderWidth = 3.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            
            let dialogue = ZAlertView(title: "Level Locked", message: "You haven't unlocked this level yet! You're on level \(toString!)", closeButtonText: "Okay", closeButtonHandler: { alertView in
                reset()
                alertView.dismiss()
            })
            dialogue.allowTouchOutsideToDismiss = false
            dialogue.show()

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
    }
    
    func startButtonReady(button: UIButton) {
        button.enabled = true
    }
}
