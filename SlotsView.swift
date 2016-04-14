//
//  SlotsView.swift
//  menuTest
//
//  Created by Daniel Robertson on 19/03/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit
class SlotsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SwiftAlertViewDelegate {
    
    var gamesView: UICollectionView!
    var tagID: Int!
    var gameSaves = Array<GameSave>()
   // var saveOverwriteSlot: (() -> ())!
    
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
               // cell.inUse = true
               // inUseCells.append(cell)
//                cell.alpha = 0.5
//                cell.userInteractionEnabled = false
            //Unpopulated cells are drawn like...
            } else {
                cell.gameName.textColor = UIColor.blackColor()
                cell.gameLevel.textColor = UIColor.blackColor()
                cell.gameName.text = "[Empty]"
                cell.gameLevel.text = "[Empty]"
                cell.tag = 1
               // cell.inUse = false
               // notInUse.append(cell)
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
                //inUseCells.append(cell)
                cell.tag = 0
            //Unpopulated cells are drawn like...
            } else {
                cell.gameName.text = "[Empty]"
                cell.gameLevel.text = "[Empty]"
                cell.gameName.textColor = UIColor.blackColor()
                cell.gameLevel.textColor = UIColor.blackColor()
                cell.tag = 1
               // notInUse.append(cell)
            }
        }

        // Configure the cell
        return cell
    }
//-----------------SETTING A CELL'S SIZE----------------------------------------------
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(300, 100)
    }

//-----------------HANDLES THE 4 SCENARIOS FOR TAPPING COLLECTION VIEW CELLS----------------------------------------------
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let activeCell = collectionView.cellForItemAtIndexPath(indexPath)
        
        func viewReset() {
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
        
        //Alertview settings
        ZAlertView.alertTitleFont = UIFont(name: "KemcoPixelBold", size: 15)
        ZAlertView.messageFont = UIFont(name: "KemcoPixelBold", size: 15)
        ZAlertView.buttonFont = UIFont(name: "KemcoPixelBold", size: 15)
        ZAlertView.titleColor = UIColor.blackColor()
        ZAlertView.messageColor = UIColor.blackColor()
        ZAlertView.cancelTextColor = UIColor.redColor()
        ZAlertView.normalTextColor = UIColor.blackColor()
        
//----SCENARIO 1----
        //If segue is New Game and the clicked cell is populated...
        if tagID == 0 && activeCell?.tag == 0 {
            
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            collectionView.userInteractionEnabled = false
            
//            let ac = UIAlertController(title: "Delete this save?", message: "Are you sure you want to delete this save? It will not be recoverable!", preferredStyle: .Alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
//               
//                self.gameSaves.removeAtIndex(indexPath.row)
//                activeCell?.tag = 1
//                
//                
//                //resets the cell's border and background colour. Enables user interaction again
//                reset()
//                
//                //rewrite gameSaves to app documents to save the change
//                self.saveGame()
//                
//                //reloads gameSaves, now one game shorter, and
//                self.loadGame()
//                
//                //reloads the data for the cells to refresh, since there is no one less saved game
//                self.gamesView.reloadData()
//                
//
//               
//                
//            }))
//            ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
//            window!.rootViewController!.presentViewController(ac, animated: true, completion: nil)
            
            let dialogue = ZAlertView(title: "Delete this save?", message: "Are you sure you want to delete this save? It will not be recoverable!", isOkButtonLeft: false, okButtonText: "Okay", cancelButtonText: "Cancel",
                okButtonHandler: { alertView in
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
                },
                cancelButtonHandler: { alertView in
                    reset()
                    alertView.dismiss()
                }
            )

            dialogue.show()
        }
//----SCENARIO 2----
        //If segue is New Game and the clicked cell is not populated...
        if tagID == 0 && activeCell?.tag == 1  {

            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            collectionView.userInteractionEnabled = false

//            let ac = UIAlertController(title: "Enter Your Name", message: "Please enter your name to start a new game!", preferredStyle: .Alert)
//            ac.addTextFieldWithConfigurationHandler({(textfield: UITextField!) -> Void in
//                textfield.placeholder = "Enter Name"
//            })
//
//            ac.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: {
//                (alert: UIAlertAction!) in
//                if let textField = ac.textFields!.first as UITextField!{
//                    if textField.text == "" {
//                        textField.text = "nil"
//                    }
//                    //New name is entered. When "okay" is pressed, newName is set to the entered name. A new gameSave object is created using the newName. This is then added to the gameSaves array. activeSave is then set to that new game. The cell is marked as used, and then saveGame is called to save the new data to app documents. The collectionview and clicked cell then reset.
//                    let newName = textField.text!
//                    let gameSave = GameSave(name: newName, progress: 3)
//                    self.appendGameSaves(gameSave)
//                    self.activeSave = gameSave
//                    activeCell?.tag = 0
//                    self.saveGame()
//                    
//                    collectionView.reloadData()
//                    reset()
//                    //Passing our active save to the GameSlotsViewController by calling the pressedCell closure.
//                    self.pressedCell(save: self.activeSave)
//                }
//            }))
            
          //  ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: viewReset))
          //  window!.rootViewController!.presentViewController(ac, animated: true, completion: nil)

            let dialogue = ZAlertView(title: "Enter Your Name", message: "Please enter your name to start a new game!", isOkButtonLeft: false, okButtonText: "Okay", cancelButtonText: "Cancel",
                       okButtonHandler: { alertView in
                },
                       cancelButtonHandler: { alertView in
                        reset()
                        print("yay?")
                        alertView.dismiss()
                }
            )
            
            dialogue.addTextField("Doot", placeHolder: "Enter Name")
            dialogue.okHandler = { alertView in
                let text = dialogue.getTextFieldWithIdentifier("Doot")
                let newName = text!.text!
                let gameSave = GameSave(name: newName, progress: 0)
                self.appendGameSaves(gameSave)
                self.activeSave = gameSave
                activeCell!.tag = 0
                print(activeCell!.tag)
                activeCell!.backgroundColor = UIColor.purpleColor()
                self.saveGame()
                collectionView.reloadData()
                viewReset()
                self.pressedCell(save: self.activeSave)
                alertView.dismiss()
            }
        
            dialogue.show()
            
                    }
//----SCENARIO 3----
        if tagID == 1 && activeCell?.tag == 0 {
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            collectionView.userInteractionEnabled = false

//            let ac = UIAlertController(title: "Confirm Load", message: "Are you sure you want to load this game?", preferredStyle: .Alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
//                (alert: UIAlertAction!) in
//                
//                    //When Okay is clicked, the current cell number is assigned to currentCellPos
//                    let currentCellPos = indexPath.row
//                    self.activeSave = self.gameSaves[currentCellPos]
//                }
//            ))
           // ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: viewReset))
          //  window!.rootViewController!.presentViewController(ac, animated: true, completion: nil)
            
            let dialogue = ZAlertView(title: "Confirm Load", message: "Are you sure you want to load this game?", isOkButtonLeft: false, okButtonText: "Yes", cancelButtonText: "Cancel",
                  okButtonHandler: { alertView in
                    let currentCellPos = indexPath.row
                    self.activeSave = self.gameSaves[currentCellPos]

                    alertView.dismiss()
                },
                  cancelButtonHandler: { alertView in
                    reset()
                    alertView.dismiss()
                }
            )
            dialogue.show()
        }
//----SCENARIO 4----
        if tagID == 1 && activeCell?.tag == 1 {
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            collectionView.userInteractionEnabled = false
            
//            let ac = UIAlertController(title: "Error", message: "No save file detected. Please select a different slot.", preferredStyle: .Alert)
//            ac.addAction(UIAlertAction(title: "Okay", style: .Cancel, handler: viewReset))
//            window!.rootViewController!.presentViewController(ac, animated: true, completion: nil)
            
//            let alertView = SwiftAlertView(title: "Error", message: "", delegate: self, cancelButtonTitle: "Okay")
//             alertView.messageLabel.attributedText = NSAttributedString(string: "No save file detected. Please select a different slot.", attributes:attributes)
//            alertView.titleLabel.textColor = UIColor.blackColor()
//            
//            alertView.titleLabel.font = UIFont(name: "KemcoPixelBold", size: 20)
//            alertView.messageLabel.textColor = UIColor.blackColor()
//            alertView.messageLabel.font = UIFont(name: "KemcoPixelBold", size: 15)
//            alertView.backgroundColor = UIColor.greenColor()
//            alertView.buttonAtIndex(0)?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//            alertView.buttonAtIndex(0)?.titleLabel?.font = UIFont(name: "KemcoPixelBold", size: 20)
//
//            alertView.show()
            
            let dialogue = ZAlertView(title: "Error", message: "No save file detected. Please select a different slot.", closeButtonText: "Okay", closeButtonHandler: { alertView in
                viewReset()
                alertView.dismiss()
            })
            
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
                print("Saves: \(gameSaves)")
            }
        }
    }
    
//    func winning() {
//        let text = dialog.getTextFieldWithIdentifier("Doot")
//        print(text?.text)
//    }
    
    
    
    

    
}
