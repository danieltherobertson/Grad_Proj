//
//  ProgressView.swift
//  TheOperator
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
    var nextLevel: Int?
    var currentGameSelected: ((level: Int, tag: Int) -> ())!
    
    override func layoutSubviews() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: 300, height: 100)
        //layout.minimumInteritemSpacing = 30
        //layout.minimumLineSpacing = 30
        
        
        levelsView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
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
      
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 4
        cell.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor

        
        let playerProgress = viewedSave.progress
            //Get saved games and populate cells
            if indexPath.row < levelsData!.count {
                let gameSlot = levelsData![indexPath.row]
                let levelName = gameSlot.valueForKey("name")!
                cell.levelName.text = levelName as? String
                cell.levelName.setLineHeight(3, alignment: .Left)
                let levelNumber = gameSlot.valueForKey("number")!
                toInt = Int(levelNumber as! String)
                let intAdd = toInt!+1
                toString = String(intAdd)
                cell.levelNumber.text = toString
                
                if indexPath.row < playerProgress {
                    cell.levelImage.image = UIImage(named: "complete")
                    cell.levelStatus = LevelStatus.Completed
                    cell.tag = 0
                
                } else if indexPath.row == playerProgress {
                    nextLevel = indexPath.row+1
                    cell.levelImage.image = UIImage(named: "current")
                    cell.userInteractionEnabled = true
                    cell.levelStatus = LevelStatus.Current
                    cell.tag = 1
                    
                } else if indexPath.row > playerProgress {
                    cell.levelImage.image = UIImage(named: "locked")
                    cell.levelStatus = LevelStatus.Locked
                    cell.levelNumber.text = "[Locked]"
                    cell.levelName.text = "[Level Locked]"
                    cell.tag = 2
                }
                cell.levelName.textColor = UIColor.blackColor()
                cell.levelNumber.textColor = UIColor.blackColor()

                //Unpopulated cells are drawn like...
            } else {
                cell.levelName.textColor = UIColor.blackColor()
                cell.levelNumber.textColor = UIColor.blackColor()
                cell.levelName.text = "[Empty]"
                cell.levelNumber.text = "[Empty]"
            }
        
        if cell.selected {
            cell.styleSelected(cell.tag)
        }
        
        // Configure the cell
        return cell
    }
    //-----------------SETTING A CELL'S SIZE----------------------------------------------
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = self.levelsView.bounds.width
        let height = self.levelsView.bounds.height/3
        return CGSize(width: width, height: height)
    }
    
    //-----------------HANDLES THE 4 SCENARIOS FOR TAPPING COLLECTION VIEW CELLS----------------------------------------------
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let activeCell = collectionView.cellForItemAtIndexPath(indexPath) as? progressCell
        
        activeCell?.styleSelected(activeCell!.tag)

        func reset() {
            activeCell?.layer.borderWidth = 0
            activeCell?.layer.borderColor = nil
            activeCell?.backgroundColor = UIColor.greenColor()
            collectionView.userInteractionEnabled = true
        }
        
        
        if activeCell?.tag == 0 {
            
            
            let currentCellPos = indexPath.row
            currentGameSelected(level: currentCellPos, tag: 0)
        }
        
        if activeCell?.tag == 1 {
            

            let currentCellPos = indexPath.row
            currentGameSelected(level: currentCellPos, tag: 1)

        }
        
        if activeCell?.tag == 2 {
            
            let currentCellPos = indexPath.row
            currentGameSelected(level: currentCellPos, tag: 2)
            
            let dialogue = ZAlertView(title: "Level Locked", message: "You haven't unlocked this level yet! You're on level \(nextLevel!)", closeButtonText: "Okay", closeButtonHandler: { alertView in
                reset()
                collectionView.reloadData()
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
        
        //collectionView.reloadItemsAtIndexPaths([indexPath])
    }
        //-----------------LOADS THE GAMESAVE ARRAY----------------------------------------------
    func loadLevels(levels: [NSDictionary]) {
        levelsData = levels
    }
    
    func startButtonReady(button: UIButton) {
        button.enabled = true
    }
}
