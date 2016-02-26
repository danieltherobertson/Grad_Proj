//
//  GameSlotsViewController.swift
//  menuTest
//
//  Created by Daniel Robertson on 18/02/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class GameSlotsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var gameSaves = Array<Dictionary<String,AnyObject>>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionTitle: UILabel!
    
    var pageTitle = String!()
    var tagID: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionTitle.text = pageTitle
        
        

        //SAVING
        let slotDictionary = ["name": "Dan","progress": 4];
        let slotDictionary2 = ["name": "Joe","progress": 0];
        
        let slotsArray = [slotDictionary, slotDictionary2];
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        if paths.count > 0 {
            let directPath = paths[0]
            let path = directPath.stringByAppendingString("gameSlots.json")
            
            let data = NSKeyedArchiver.archivedDataWithRootObject(slotsArray)
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
                gameSaves = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Array<Dictionary<String,AnyObject>>
                print(gameSaves)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("gameCell", forIndexPath: indexPath) as! gameCell
        
        
        if tagID == 0 {
            if indexPath.row < gameSaves.count {
                let gameSlot = gameSaves[indexPath.row]
                let gameNameText = gameSlot["name"] as? String
                cell.gameName.text = "Name: \(gameNameText!)"
                let gameLevelText = String(gameSlot["progress"] as! Int)
                cell.gameLevel.text = "Level Progress: \(gameLevelText)"
                cell.gameName.textColor = UIColor.blackColor()
                cell.gameLevel.textColor = UIColor.blackColor()
            } else {
                cell.gameName.text = "[Empty]"
                cell.gameLevel.text = "[Empty]"
                cell.backgroundColor = UIColor.lightGrayColor()
                cell.alpha = 0.5
                cell.userInteractionEnabled = false
            }
            
            func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
                let activeCell = collectionView.cellForItemAtIndexPath(indexPath)
                
                activeCell?.layer.borderWidth = 2.0
                activeCell?.layer.borderColor = UIColor.redColor().CGColor
                activeCell?.backgroundColor = UIColor.blueColor()
                
                
                collectionView.reloadItemsAtIndexPaths([indexPath])
                
            }

            
            
        } else if tagID == 1 {
            if indexPath.row < gameSaves.count {
                let gameSlot = gameSaves[indexPath.row]
                let gameNameText = gameSlot["name"] as? String
                cell.gameName.text = "Name: \(gameNameText!)"
                let gameLevelText = String(gameSlot["progress"] as! Int)
                cell.gameLevel.text = "Level Progress: \(gameLevelText)"
                cell.gameName.textColor = UIColor.redColor()
                cell.gameLevel.textColor = UIColor.redColor()
            } else {
                cell.gameName.text = "[Empty]"
                cell.gameLevel.text = "[Empty]"
                cell.backgroundColor = UIColor.lightGrayColor()
                cell.alpha = 0.5
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
 
        if tagID == 0 {
            
            print("cell has been tapped", indexPath)
        
            activeCell?.layer.borderWidth = 2.0
            activeCell?.layer.borderColor = UIColor.redColor().CGColor
            activeCell?.backgroundColor = UIColor.blueColor()
            collectionView.userInteractionEnabled = false
            

            let ac = UIAlertController(title: "Confirm Slot", message: "Are you sure you want to use this save slot? Selecting 'Yes' will start the game.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: gameStart))
            ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            self.presentViewController(ac, animated: true, completion: nil)
            
            
            collectionView.reloadItemsAtIndexPaths([indexPath])
        }
        
    }
    
    func gameStart(alertAction: UIAlertAction) {
        self.performSegueWithIdentifier("beginGame", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("hello")
      
        let activeCell = collectionView.cellForItemAtIndexPath(indexPath)

        activeCell?.layer.borderWidth = 0
        activeCell?.layer.borderColor = nil
        
        
        collectionView.reloadItemsAtIndexPaths([indexPath])
    }
    
    func gameStart() {
        print("WORKING")
    }
    
}
