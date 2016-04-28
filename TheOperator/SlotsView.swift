//
//  SlotsView.swift
//  TheOperator
//
//  Created by Daniel Robertson on 19/03/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit
class SlotsView: UIView {
    
    var gamesView: UICollectionView!
    var tagID: Int!
    var gameSaves = Array<GameSave>()
    
    //pressedCell is a closure that takes a gamesave as a param
    var pressedCell: ((save: GameSave) -> ())!
    
    var activeSave: GameSave!

    override func layoutSubviews() {
        super.layoutSubviews()
        
        gamesView.frame = self.bounds
        
    }
//-----------------INITIALISING THE COLLECTION VIEW INSIDE THE UIVIEW ----------------------------------------------
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 100)
        
        gamesView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        gamesView.translatesAutoresizingMaskIntoConstraints = false
        gamesView.dataSource = self
        gamesView.delegate = self
        
        let nib = UINib(nibName: "gameCellNib", bundle: nil)
        gamesView.registerNib(nib, forCellWithReuseIdentifier: "gameCell")
        gamesView.backgroundColor = UIColor.clearColor()
        self.addSubview(gamesView)
        
        //Load any existing gameSave types from gameSaves
        loadGame()
        
    }
    

  //-----------------ADDS A NEW GAME SAVE OBJECT TO THE GAMESAVES ARRAY----------------------------------------------
    func appendGameSaves(gameSave: GameSave) {
       gameSaves.append(gameSave)
    }
//-----------------SAVES THE GAMESAVES ARRAY----------------------------------------------
    func saveGame() {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        if paths.count > 0 {
            let directPath = paths[0]
            let path = directPath.stringByAppendingString("/gameSlots.json")

            let data = NSKeyedArchiver.archivedDataWithRootObject(gameSaves)
            data.writeToFile(path, atomically: true)
        }
    }
//-----------------LOADS THE GAMESAVE ARRAY----------------------------------------------
    func loadGame() {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if paths.count > 0 {
            let directPath = paths[0]
            let path = directPath.stringByAppendingString("/gameSlots.json")
            
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(path) {
                let data = NSData(contentsOfFile: path)!
                gameSaves = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Array<GameSave>
            }
        }
    }
}

extension SlotsView: UICollectionViewDataSource {
    //-----------------NUMBER OF CELLS----------------------------------------------
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
        
    }
    
    //-----------------ADDS DATA TO THE CELLS, OR DRAWS THEM AS EMPTY----------------------------------------------
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("gameCell", forIndexPath: indexPath) as! gameCell
        
        //if coming from NewGame segue...
        if tagID == 0 {
            
            //Get saved games and populate cells
            if indexPath.row < gameSaves.count {
                let gameSlot = gameSaves[indexPath.row]
                let gameNameText = gameSlot.name
                cell.gameName.text = "Name: \(gameNameText!)"
                let gameLevelText = gameSlot.progress
                cell.gameLevel.text = "Progress: \(gameLevelText)"
                cell.gameName.textColor = UIColor.blackColor()
                cell.gameLevel.textColor = UIColor.blackColor()
                cell.tag = 0
                //Unpopulated cells are drawn like...
            } else {
                cell.gameName.textColor = UIColor.blackColor()
                cell.gameLevel.textColor = UIColor.blackColor()
                cell.gameName.text = "[Empty]"
                cell.gameLevel.text = "[Empty]"
                cell.tag = 1
            }
            
            //if coming from LoadGame segue...
        } else if tagID == 1 {
            //Get saved games and populate cells
            if indexPath.row < gameSaves.count {
                let gameSlot = gameSaves[indexPath.row]
                let gameNameText = gameSlot.name
                cell.gameName.text = "Name: \(gameNameText!)"
                let gameLevelText = gameSlot.progress
                cell.gameLevel.text = "Progress: \(gameLevelText)"
                cell.gameName.textColor = UIColor.blackColor()
                cell.gameLevel.textColor = UIColor.blackColor()

                cell.tag = 0
                //Unpopulated cells are drawn like...
            } else {
                cell.gameName.text = "[Empty]"
                cell.gameLevel.text = "[Empty]"
                cell.gameName.textColor = UIColor.blackColor()
                cell.gameLevel.textColor = UIColor.blackColor()
                cell.tag = 1
            }
        }
        // Configure the cell
        return cell
    }
}

extension SlotsView: UICollectionViewDelegateFlowLayout {
    //-----------------SETTING A CELL'S SIZE----------------------------------------------
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(280, 100)
    }
    
    //-----------------HANDLES THE 4 SCENARIOS FOR TAPPING COLLECTION VIEW CELLS----------------------------------------------
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let activeCell = collectionView.cellForItemAtIndexPath(indexPath)
 
        func reset() {
            activeCell?.layer.borderWidth = 0
            activeCell?.layer.borderColor = nil
            activeCell?.backgroundColor = UIColor.greenColor()
            collectionView.userInteractionEnabled = true
            activeCell?.userInteractionEnabled = true
        }
        
        //Alertview settings
        ZAlertView.titleColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        ZAlertView.messageColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        ZAlertView.cancelTextColor = UIColor.redColor()
        ZAlertView.normalTextColor = UIColor.blackColor()
        
        //----SCENARIO 1----
        //If segue is New Game and the clicked cell is populated...
        if tagID == 0 && activeCell?.tag == 0 {
            
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            activeCell?.userInteractionEnabled = false
            collectionView.userInteractionEnabled = false
            
            let dialogue = ZAlertView(title: "Delete this save?", message: "Are you sure you want to delete this save? It will not be recoverable!", isOkButtonLeft: true, okButtonText: "Cancel", cancelButtonText: "Okay",
                  okButtonHandler: { alertView in
                    reset()
                    alertView.dismiss()
                },
                  cancelButtonHandler: { alertView in
                    self.gameSaves.removeAtIndex(indexPath.row)
                    activeCell?.tag = 1
                    
                    //resets the cell's border and background colour. Enables user interaction again
                    reset()
                    
                    //rewrite gameSaves to app documents to save the change
                    self.saveGame()
                    
                    //reloads gameSaves, now one game shorter, and
                    self.loadGame()
                    
                    //reloads the data for the cells to refresh, since there is no one less saved game
                    self.gamesView.reloadData()
                    
                    alertView.dismiss()
                }
            )
            dialogue.allowTouchOutsideToDismiss = false
            dialogue.show()
        }
        //----SCENARIO 2----
        //If segue is New Game and the clicked cell is not populated...
        if tagID == 0 && activeCell?.tag == 1  {
            
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            activeCell?.userInteractionEnabled = false
            collectionView.userInteractionEnabled = false
            
            let dialogue = ZAlertView(title: "Enter Your Name", message: "Please enter your name to start a new game!", isOkButtonLeft: false, okButtonText: "Okay", cancelButtonText: "Cancel",
                  okButtonHandler: { alertView in
                },
                  cancelButtonHandler: { alertView in
                    reset()
                    alertView.dismiss()
                }
            )
            dialogue.lbMessage.textAlignment = .Center
            dialogue.addTextField("Doot", placeHolder: "Enter Name")
            dialogue.okHandler = { alertView in
                let text = dialogue.getTextFieldWithIdentifier("Doot")
                if text!.text! == "" {
                    text!.text = "Player \(self.gameSaves.count+1)"
                }
                let newName = text!.text!
                let gameSave = GameSave(name: newName, progress: 0)
                self.appendGameSaves(gameSave)
                self.activeSave = gameSave
                activeCell!.tag = 0
                activeCell!.backgroundColor = UIColor.purpleColor()
                self.saveGame()
                collectionView.reloadData()
                reset()
                self.pressedCell(save: self.activeSave)
                alertView.dismiss()
            }
            dialogue.allowTouchOutsideToDismiss = false
            dialogue.show()
            
        }
        //----SCENARIO 3----
        if tagID == 1 && activeCell?.tag == 0 {
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            activeCell?.userInteractionEnabled = false
            collectionView.userInteractionEnabled = false
            
            let dialogue = ZAlertView(title: "Confirm Load", message: "Are you sure you want to load this game?", isOkButtonLeft: false, okButtonText: "Yes", cancelButtonText: "Cancel",
                  okButtonHandler: { alertView in
                    let currentCellPos = indexPath.row
                    self.activeSave = self.gameSaves[currentCellPos]
                    self.pressedCell(save: self.activeSave)
                    alertView.dismiss()
                },
                  cancelButtonHandler: { alertView in
                    reset()
                    alertView.dismiss()
                }
            )
            dialogue.allowTouchOutsideToDismiss = false
            dialogue.show()
        }
        //----SCENARIO 4----
        if tagID == 1 && activeCell?.tag == 1 {
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            activeCell?.userInteractionEnabled = false
            collectionView.userInteractionEnabled = false
            
            let dialogue = ZAlertView(title: "Error", message: "No save file detected. Please select a different slot.", closeButtonText: "Okay", closeButtonHandler: { alertView in
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
}
