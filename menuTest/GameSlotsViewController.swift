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
    
//    var newName = ""
    
    let gif = UIImage.gifWithName("slots_background")

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        gameSlotsView.backgroundColor = UIColor.clearColor()
      //  gameSlotsView.pressedCell = segueToLevels
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        style.alignment = NSTextAlignment.Center
        let attributes = [NSParagraphStyleAttributeName : style]
        collectionLabel.attributedText = NSAttributedString(string: pageLabel, attributes:attributes)
        
        background.image = gif
        
        backButton.layer.cornerRadius = 20
        backButton.layer.borderWidth = 4
        backButton.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
        gameSlotsView.tagID = tagID
      //  gameSlotsView.saveOverwriteSlot = {() -> Void in
            
      //  }

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

//    func gameStart(alertAction: UIAlertAction!) {
//        print(newName)
//        self.performSegueWithIdentifier("beginGame", sender: self)
//    }
    
    
    func segueToLevels() {
        performSegueWithIdentifier("gameChosen", sender: self)
    }
}

