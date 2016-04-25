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
    var pageTitle: String?
    var pageLabel: String?
    var tagID: Int!
    
    var selectedSave: GameSave?
    
    let gif = UIImage.gifWithName("slots_background")

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        gameSlotsView.backgroundColor = UIColor.clearColor()
        backButton.buttonStyle(backButton)
        
        //Calling pressedCell, the closure which contains the active save. We assign this to segueToLevels(). When pressedCell is called in SlotsView, it is already assigned segueToLevels.
        gameSlotsView.pressedCell = segueToLevels
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        style.alignment = NSTextAlignment.Center
        let attributes = [NSParagraphStyleAttributeName : style]
        collectionLabel.attributedText = NSAttributedString(string: pageLabel!, attributes:attributes)
        
        background.image = gif
        
        backButton.layer.cornerRadius = 20
        backButton.layer.borderWidth = 4
        backButton.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
        gameSlotsView.tagID = tagID
        collectionTitle.text = pageTitle
    }
    
    @IBAction func backButton(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func segueToLevels(save: GameSave) {
        //Assigning the passed savefile to selectedSave for the segue
        selectedSave = save
        performSegueWithIdentifier("gameChosen", sender: self)
 
    }
    
    //Here we pass the selected save from the collection view to the progressview using prepareForSegue. First we unwrap selectedSave. Then we set progressVC's currentSave property to be selectedSave.
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let selectedSave = selectedSave {
            let progressVC = (segue.destinationViewController as? ProgressViewController)
            progressVC?.currentSave = selectedSave
        }
    }
}

