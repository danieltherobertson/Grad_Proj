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
    var viewedSave: GameSave?
    var levelsData: [NSDictionary]!
    var toInt:Int?
    var toString:String?
    var nextLevel: Int?
    var currentGameSelected: ((level: Int, tag: Int) -> ())!
    var playTutorial: (() -> ())!
    
    override func layoutSubviews() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        
        
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

        
        let playerProgress = viewedSave!.progress
        let playerRanks = viewedSave!.rankings
            //Get saved games and populate cells
            if indexPath.row < levelsData!.count {
                let gameSlot = levelsData![indexPath.row]
                let levelName = gameSlot.valueForKey("name")!
                cell.levelName.text = levelName as? String
                cell.levelName.setLineHeight(3, alignment: .Left)
                
                if indexPath.row < playerProgress {
                    cell.levelName.text = levelName as? String
                    cell.levelImage.image = UIImage(named: "complete")
                    cell.levelStatus = LevelStatus.Completed
                    cell.levelCompleted.text = "Completed"
                    cell.levelCompleted.textColor = .blackColor()
                    cell.levelRank.text = ("Rank: \(playerRanks[indexPath.row])")
                    cell.tag = 0
                
                } else if indexPath.row == playerProgress {
                    nextLevel = indexPath.row+1
                    cell.levelName.text = levelName as? String
                    cell.levelImage.image = UIImage(named: "current")
                    cell.userInteractionEnabled = true
                    cell.levelStatus = LevelStatus.Current
                    cell.levelCompleted.text = "Incomplete"
                    cell.levelCompleted.textColor = .redColor()
                    cell.levelRank.text = ("Rank: ----")
                    cell.tag = 1
                    
                } else if indexPath.row > playerProgress {
                    cell.levelImage.image = UIImage(named: "locked")
                    cell.levelStatus = LevelStatus.Locked
                    cell.levelCompleted.text = "[Level Locked]"
                    cell.levelCompleted.textColor = .blackColor()
                    cell.levelName.text = " "
                    cell.levelRank.text = " "
                    cell.tag = 2
                }
                cell.levelName.textColor = UIColor.blackColor()
               // cell.levelNumber.textColor = UIColor.blackColor()

                //Unpopulated cells are drawn like...
            } else {
                cell.levelName.textColor = UIColor.blackColor()
                //cell.levelNumber.textColor = UIColor.blackColor()
                cell.levelName.text = "[Empty]"
               // cell.levelNumber.text = "[Empty]"
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
            
            if currentCellPos == 0 {
                let dialogue = ZAlertView(title: "Play Tutorial?", message: "Already know how to play? You can skip the tutorial!", isOkButtonLeft: true, okButtonText: "Play", cancelButtonText: "Skip", okButtonHandler: { (alertView) in
                        self.currentGameSelected(level: currentCellPos, tag: 1)
                        self.playTutorial()
                        alertView.dismiss()
                    }, cancelButtonHandler: { (alertView) in
                        self.viewedSave!.progress!+=1
                        self.viewedSave!.rankings.append("Cadet")
                        self.overwriteGame()
                        reset()
                        collectionView.reloadData()
                        alertView.dismiss()
                })
                dialogue.allowTouchOutsideToDismiss = false
                dialogue.show()
            } else {
                currentGameSelected(level: currentCellPos, tag: 1)
            }
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
        
        activeCell?.layer.cornerRadius = 20
        activeCell?.layer.borderWidth = 4
        activeCell?.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor

        
        //collectionView.reloadItemsAtIndexPaths([indexPath])
    }
        //-----------------LOADS THE GAMESAVE ARRAY----------------------------------------------
    func loadLevels(levels: [NSDictionary]) {
        levelsData = levels
    }
    
    func startButtonReady(button: UIButton) {
        button.enabled = true
    }
    
    func overwriteGame() {
        
        if viewedSave != nil {
            
            let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            
            if paths.count > 0 {
                let directPath = paths[0]
                let path = directPath.stringByAppendingString("/gameSlots.json")
                
                let fileManager = NSFileManager.defaultManager()
                if fileManager.fileExistsAtPath(path) {
                    let data = NSData(contentsOfFile: path)!
                    var gameSaves = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Array<GameSave>
                    for (index, save) in gameSaves.enumerate() {
                        if save.name == viewedSave!.name {
                            //FOUND THE RIGHT SAVE
                            gameSaves[index] = viewedSave!
                            
                            let data = NSKeyedArchiver.archivedDataWithRootObject(gameSaves)
                            data.writeToFile(path, atomically: true)
                            
                            break
                        }
                    }
                    
                }
            }
        }
    }
}
