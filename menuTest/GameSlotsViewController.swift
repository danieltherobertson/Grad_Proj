//
//  GameSlotsViewController.swift
//  menuTest
//
//  Created by Daniel Robertson on 18/02/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit
import Crashlytics

class GameSlotsViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    //adds the slotsView reference
    @IBOutlet weak var gameSlotsView: SlotsView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var background: UIImageView!
    var pageTitle = String!()
    var pageLabel = String!()
    var tagID: Int!
    
    var inUseCells = Array<UICollectionViewCell>()
    var notInUse = Array<UICollectionViewCell>()
    
    var newName = ""
    
    let gif = UIImage.gifWithName("slots_background")
 

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        gameSlotsView.backgroundColor = UIColor.clearColor()
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        style.alignment = NSTextAlignment.Center
        let attributes = [NSParagraphStyleAttributeName : style]
        collectionLabel.attributedText = NSAttributedString(string: pageLabel, attributes:attributes)

//        let button = UIButton(type:UIButtonType.RoundedRect)
//        button.frame = CGRectMake(20, 50, 100, 30)
//        button.setTitle("Crash", forState: UIControlState.Normal)
//        button.addTarget(self, action: "crashButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
//        view.addSubview(button)
        
        background.image = gif
        
        backButton.layer.cornerRadius = 20
        backButton.layer.borderWidth = 4
        backButton.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
        gameSlotsView.tagID = tagID
        gameSlotsView.saveOverwriteSlot = {() -> Void in
         
        
       
        }
        
        
        
//        func crashButtonTapped(sender: AnyObject) {
//            Crashlytics.sharedInstance().crash()
//        }

        
        collectionTitle.text = pageTitle
       // collectionLabel.text = pageLabel
    }
    
    
    @IBAction func backButton(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("gameCell", forIndexPath: indexPath) as! gameCell
//        
//        //if coming from NewGame segue...
//        if tagID == 0 {
//            //Get saved games and populate cells
//            if indexPath.row < gameSaves.count {
//                let gameSlot = gameSaves[indexPath.row]
//                let gameNameText = gameSlot["name"] as? String
//                cell.gameName.text = "Name: \(gameNameText!)"
//                let gameLevelText = gameSlot["progress"] as! String
//                cell.gameLevel.text = "Progress: \(gameLevelText)"
//                cell.gameName.textColor = UIColor.blackColor()
//                cell.gameLevel.textColor = UIColor.blackColor()
//                cell.inUse = true
//                inUseCells.append(cell)
////                cell.alpha = 0.5
////                cell.userInteractionEnabled = false
//                
//            //Unpopulated cells are drawn like...
//            } else {
//                cell.gameName.textColor = UIColor.blackColor()
//                cell.gameLevel.textColor = UIColor.blackColor()
//                cell.gameName.text = "[Empty]"
//                cell.gameLevel.text = "[Empty]"
//                cell.inUse = false
//                notInUse.append(cell)
//            }
//        
//        //if coming from LoadGame segue...
//        } else if tagID == 1 {
//            //Get saved games and populate cells
//            if indexPath.row < gameSaves.count {
//                let gameSlot = gameSaves[indexPath.row]
//                let gameNameText = gameSlot["name"] as? String
//                cell.gameName.text = "Name: \(gameNameText!)"
//                let gameLevelText = gameSlot["progress"] as! String
//                cell.gameLevel.text = "Progress: \(gameLevelText)"
//                cell.gameName.textColor = UIColor.blackColor()
//                cell.gameLevel.textColor = UIColor.blackColor()
//                inUseCells.append(cell)
//            //Unpopulated cells are drawn like...
//            } else {
//                cell.gameName.text = "[Empty]"
//                cell.gameLevel.text = "[Empty]"
//                cell.gameName.textColor = UIColor.blackColor()
//                cell.gameLevel.textColor = UIColor.blackColor()
//                notInUse.append(cell)
//            }
//        }
//
//        // Configure the cell
//        return cell
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSizeMake(300, 100)
//    }
//    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let activeCell = collectionView.cellForItemAtIndexPath(indexPath)
//        
//        print("notInUse capacity:\(notInUse.capacity)")
//        print("inUseCells capactiy\(inUseCells.capacity)")
//        
//        func viewReset(alertAction: UIAlertAction) {
//            activeCell?.layer.borderWidth = 0
//            activeCell?.layer.borderColor = nil
//            activeCell?.backgroundColor = UIColor.greenColor()
//            collectionView.userInteractionEnabled = true
//        }
//        
//        //If segue is New Game and the clicked cell is populated...
//        if tagID == 0 && inUseCells.contains(activeCell!){
//
//            print("cell has been tapped", indexPath)
//        
//            activeCell?.layer.borderWidth = 2.0
//            activeCell?.layer.borderColor = UIColor.redColor().CGColor
//            collectionView.userInteractionEnabled = false
//
//            let ac = UIAlertController(title: "Confirm Overwrite", message: "Are you sure you want to overwrite an existing game?", preferredStyle: .Alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: gameStart))
//            ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: viewReset))
//            self.presentViewController(ac, animated: true, completion: nil)
//        }
//        
//        //If segue is New Game and the clicked cell is not populated...
//        if tagID == 0 && notInUse.contains(activeCell!) {
//
//            print("cell has been tapped", indexPath)
//
//            activeCell?.layer.borderWidth = 2.0
//            activeCell?.layer.borderColor = UIColor.redColor().CGColor
//            collectionView.userInteractionEnabled = false
//
//            let ac = UIAlertController(title: "Enter Your Name", message: "Please enter your name to start a new game!", preferredStyle: .Alert)
//            ac.addTextFieldWithConfigurationHandler({(textfield: UITextField!) -> Void in
//                textfield.placeholder = "Enter Name"
//            })
//            ac.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: {
//                (alert: UIAlertAction!) in
//                if let textField = ac.textFields!.first as UITextField!{
//                    self.newName = textField.text!
//                }
//                self.gameStart(alert)
//            }))
//            ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: viewReset))
//            self.presentViewController(ac, animated: true, completion: nil)
//        }
//        
//        if tagID == 1 && inUseCells.contains(activeCell!) {
//            activeCell?.layer.borderWidth = 2.0
//            activeCell?.layer.borderColor = UIColor.redColor().CGColor
//            collectionView.userInteractionEnabled = false
//            
//            let ac = UIAlertController(title: "Confirm Load", message: "Are you sure you want to load this game?", preferredStyle: .Alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: gameStart))
//            ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: viewReset))
//            self.presentViewController(ac, animated: true, completion: nil)
//        }
//        
//        if tagID == 1 && notInUse.contains(activeCell!) {
//            activeCell?.layer.borderWidth = 2.0
//            activeCell?.layer.borderColor = UIColor.redColor().CGColor
//            collectionView.userInteractionEnabled = false
//            
//            let ac = UIAlertController(title: "Error", message: "No save file detected. Please select a different slot.", preferredStyle: .Alert)
//            ac.addAction(UIAlertAction(title: "Okay", style: .Cancel, handler: viewReset))
//            self.presentViewController(ac, animated: true, completion: nil)
//        }
//        
//        func getText(alertAction: UIAlertAction!) {
//        
//        }
//    }
    
//    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
//      
//        let activeCell = collectionView.cellForItemAtIndexPath(indexPath)
//
//        activeCell?.layer.borderWidth = 0
//        activeCell?.layer.borderColor = nil
//        
//        collectionView.reloadItemsAtIndexPaths([indexPath])
//    }
//
    func gameStart(alertAction: UIAlertAction!) {
        print(newName)
        self.performSegueWithIdentifier("beginGame", sender: self)
    }
}

