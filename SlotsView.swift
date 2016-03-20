//
//  SlotsView.swift
//  menuTest
//
//  Created by Daniel Robertson on 19/03/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit
class SlotsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var gamesView: UICollectionView!
    var tagID: Int!
    var gameSaves = Array<GameSave>()
    var saveOverwriteSlot: (() -> ())!
    
    let gameSave = GameSave(name: "Dan", progress: 5)
    let gameSave2 = GameSave(name: "Joe", progress: 2)
    
     var newName = ""

    
    
    var inUseCells = Array<UICollectionViewCell>()
    var notInUse = Array<UICollectionViewCell>()
    
    override func layoutSubviews() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        layout.itemSize = CGSize(width: 300, height: 100)
        
        gamesView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        gamesView.dataSource = self
        gamesView.delegate = self

        let nib:UINib = UINib(nibName: "gameCellNib", bundle: nil)
        gamesView.registerNib(nib, forCellWithReuseIdentifier: "gameCell")
        
        self.addSubview(gamesView)
    }
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        gameSaves.append(gameSave)
        gameSaves.append(gameSave2)
    }
    
    func viewDidLoad() {
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        if paths.count > 0 {
            let directPath = paths[0]
            let path = directPath.stringByAppendingString("gameSlots.json")
            
            let data = NSKeyedArchiver.archivedDataWithRootObject(gameSaves)
            data.writeToFile(path, atomically: true)
        }
        
        //LOAD SAVES
        //        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if paths.count > 0 {
            let directPath = paths[0]
            let path = directPath.stringByAppendingString("gameSlots.json")
            
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(path) {
                let data = NSData(contentsOfFile: path)!
                gameSaves = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Array<GameSave>
                print(gameSaves)
            }
        }

    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("gameCell", forIndexPath: indexPath) as! gameCell

        //if coming from NewGame segue...
        if tagID == 0 {
            print("WOWOWOWOWOWOW")
            print(gameSaves.count)
            //Get saved games and populate cells
            if indexPath.row < gameSaves.count {
                let gameSlot = gameSaves[indexPath.row]
                let gameNameText = gameSlot.name
                cell.gameName.text = "Name: \(gameNameText!)"
                let gameLevelText = gameSlot.progress
                cell.gameLevel.text = "Progress: \(gameLevelText)"
                cell.gameName.textColor = UIColor.blackColor()
                cell.gameLevel.textColor = UIColor.blackColor()
                cell.inUse = true
                inUseCells.append(cell)
//                cell.alpha = 0.5
//                cell.userInteractionEnabled = false

            //Unpopulated cells are drawn like...
            } else {
                cell.gameName.textColor = UIColor.blackColor()
                cell.gameLevel.textColor = UIColor.blackColor()
                cell.gameName.text = "[Empty]"
                cell.gameLevel.text = "[Empty]"
                cell.inUse = false
                notInUse.append(cell)
            }

        //if coming from LoadGame segue...
        } else if tagID == 1 {
            print("JAM")
            //Get saved games and populate cells
            if indexPath.row < gameSaves.count {
                let gameSlot = gameSaves[indexPath.row]
                let gameNameText = gameSlot.name
                cell.gameName.text = "Name: \(gameNameText!)"
                let gameLevelText = gameSlot.progress
                cell.gameLevel.text = "Progress: \(gameLevelText)"
                cell.gameName.textColor = UIColor.blackColor()
                cell.gameLevel.textColor = UIColor.blackColor()
                inUseCells.append(cell)
            //Unpopulated cells are drawn like...
            } else {
                cell.gameName.text = "[Empty]"
                cell.gameLevel.text = "[Empty]"
                cell.gameName.textColor = UIColor.blackColor()
                cell.gameLevel.textColor = UIColor.blackColor()
                notInUse.append(cell)
            }
        }

        // Configure the cell
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(300, 100)
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let activeCell = collectionView.cellForItemAtIndexPath(indexPath)

        print("notInUse capacity:\(notInUse.capacity)")
        print("inUseCells capactiy\(inUseCells.capacity)")

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

        //If segue is New Game and the clicked cell is populated...
        if tagID == 0 && inUseCells.contains(activeCell!){

            print("cell has been tapped", indexPath)

            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            collectionView.userInteractionEnabled = false
            self.saveOverwriteSlot()
            reset()
        }

        //If segue is New Game and the clicked cell is not populated...
        if tagID == 0 && notInUse.contains(activeCell!) {

            print("cell has been tapped", indexPath)

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
                    self.newName = textField.text!
                }
              //  self.gameStart(alert)
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: viewReset))
            window!.rootViewController!.presentViewController(ac, animated: true, completion: nil)
        }

        if tagID == 1 && inUseCells.contains(activeCell!) {
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            collectionView.userInteractionEnabled = false

            let ac = UIAlertController(title: "Confirm Load", message: "Are you sure you want to load this game?", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: viewReset))
            window!.rootViewController!.presentViewController(ac, animated: true, completion: nil)
        }

        if tagID == 1 && notInUse.contains(activeCell!) {
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            collectionView.userInteractionEnabled = false
            
            let ac = UIAlertController(title: "Error", message: "No save file detected. Please select a different slot.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .Cancel, handler: viewReset))
            window!.rootViewController!.presentViewController(ac, animated: true, completion: nil)

        }
        
        func getText(alertAction: UIAlertAction!) {
        
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
      
        let activeCell = collectionView.cellForItemAtIndexPath(indexPath)

        activeCell?.layer.borderWidth = 0
        activeCell?.layer.borderColor = nil
        
        collectionView.reloadItemsAtIndexPaths([indexPath])
    }

    
}
