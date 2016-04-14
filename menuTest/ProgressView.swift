//
//  SlotsView.swift
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
    var saveOverwriteSlot: (() -> ())!
    
    let gameSave = GameSave(name: "Dan", progress: 5)
    let gameSave2 = GameSave(name: "Joe", progress: 2)
    
    var levelsData: [NSDictionary]?
    
    //var inUseCells = Array<UICollectionViewCell>()
    // var notInUse = Array<UICollectionViewCell>()
    
    
    override func layoutSubviews() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 100)
        
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

            
            //Get saved games and populate cells
            if indexPath.row < gameSaves.count {
                let gameSlot = gameSaves[indexPath.row]
                let gameNameText = gameSlot.name
                //cell.gameName.text = "Name: \(gameNameText!)"
                let gameLevelText = gameSlot.progress
               // cell.gameLevel.text = "Progress: \(gameLevelText)"
               // cell.gameName.textColor = UIColor.blackColor()
               // cell.gameLevel.textColor = UIColor.blackColor()
               // cell.tag = 0
                // cell.inUse = true
                // inUseCells.append(cell)
                //                cell.alpha = 0.5
                //                cell.userInteractionEnabled = false
                //Unpopulated cells are drawn like...
            } else {
//                cell.gameName.textColor = UIColor.blackColor()
//                cell.gameLevel.textColor = UIColor.blackColor()
//                cell.gameName.text = "[Empty]"
//                cell.gameLevel.text = "[Empty]"
//                cell.tag = 1
                // cell.inUse = false
                // notInUse.append(cell)
            }
        
        // Configure the cell
        return cell
    }
    //-----------------SETTING A CELL'S SIZE----------------------------------------------
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(90, 90)
    }
    
    //-----------------HANDLES THE 4 SCENARIOS FOR TAPPING COLLECTION VIEW CELLS----------------------------------------------
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let activeCell = collectionView.cellForItemAtIndexPath(indexPath)
        
        // print("notInUse capacity:\(notInUse.capacity)")
        // print("inUseCells capactiy\(inUseCells.capacity)")
        
        print(gameSaves)
        
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
        //----SCENARIO 1----
        //If segue is New Game and the clicked cell is populated...
        if tagID == 0 && activeCell?.tag == 0 {
            
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            collectionView.userInteractionEnabled = false
            
            let ac = UIAlertController(title: "Delete this save?", message: "Are you sure you want to delete this save? It will not be recoverable!", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                
                self.gameSaves.removeAtIndex(indexPath.row)
                activeCell?.tag = 1
                
                
                //resets the cell's border and background colour. Enables user interaction again
                reset()
                
                //rewrite gameSaves to app documents to save the change
                self.saveGame()
                
                //reloads gameSaves, now one game shorter, and
               // self.loadGame()
                
                //reloads the data for the cells to refresh, since there is no one less saved game
                self.levelsView.reloadData()
                
                
                
                
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: viewReset))
            window!.rootViewController!.presentViewController(ac, animated: true, completion: nil)
            
            // reset()
        }
        //----SCENARIO 2----
        //If segue is New Game and the clicked cell is not populated...
        if tagID == 0 && activeCell?.tag == 1  {
            
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            collectionView.userInteractionEnabled = false
            
            let ac = UIAlertController(title: "Enter Your Name", message: "Please enter your name to start a new game!", preferredStyle: .Alert)
            ac.addTextFieldWithConfigurationHandler({(textfield: UITextField!) -> Void in
                textfield.placeholder = "Enter Name"
            })
            
            ac.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: {
                (alert: UIAlertAction!) in
                if let textField = ac.textFields!.first as UITextField!{
                    if textField.text == "" {
                        textField.text = "nil"
                    }
                    
                    let newName = textField.text!
                    let gameSave = GameSave(name: newName, progress: 0)
                    self.appendGameSaves(gameSave)
                    activeCell?.tag = 0
                    self.saveGame()
                    
                    collectionView.reloadData()
                    reset()
                }
            }))
            
            ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: viewReset))
            window!.rootViewController!.presentViewController(ac, animated: true, completion: nil)
        }
        //----SCENARIO 3----
        if tagID == 1 && activeCell?.tag == 0 {
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            collectionView.userInteractionEnabled = false
            
            let ac = UIAlertController(title: "Confirm Load", message: "Are you sure you want to load this game?", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: viewReset))
            window!.rootViewController!.presentViewController(ac, animated: true, completion: nil)
        }
        //----SCENARIO 4----
        if tagID == 1 && activeCell?.tag == 1 {
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            collectionView.userInteractionEnabled = false
            
            let ac = UIAlertController(title: "Error", message: "No save file detected. Please select a different slot.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .Cancel, handler: viewReset))
            window!.rootViewController!.presentViewController(ac, animated: true, completion: nil)
            
        }
    }
    //-----------------HANDLES DESELECTING CELLS IN THE COLLECTION VIEW----------------------------------------------
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        let activeCell = collectionView.cellForItemAtIndexPath(indexPath)
        
        activeCell?.layer.borderWidth = 0
        activeCell?.layer.borderColor = nil
        
        collectionView.reloadItemsAtIndexPaths([indexPath])
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
    func loadLevels(levels: [NSDictionary]) {
        levelsData = levels
        
        print("printing levelss \(levelsData)")
    }
    
   
    
    
}
