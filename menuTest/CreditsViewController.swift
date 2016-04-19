//
//  CreditsViewController.swift
//  menuTest
//
//  Created by Daniel Robertson on 08/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit
import Foundation

class CreditsViewController: UIViewController {


    @IBOutlet weak var creditsText: UITextView!
    @IBOutlet weak var backButton: UIButton!
    
    var cred_l1: String!
    var cred_l2: String!
    var cred_l3: String!
    var cred_l4: String!
    
    var charSets: Array<String>!
    var charArray: Array<Character>!

    var timer: NSTimer?
    var activeLine = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.cornerRadius = 20
        backButton.layer.borderWidth = 4
        backButton.layer.borderColor = UIColor(red: 25/255, green: 165/255, blue: 38/255, alpha: 1).CGColor
        
        activeLine = 0
        creditsText.textColor = UIColor.greenColor()
        creditsText.editable = false
        creditsText.selectable = false
        timer = NSTimer.scheduledTimerWithTimeInterval(1 , target: self, selector: #selector(typeStart), userInfo: nil, repeats: false)

    }
    
    func typeStart() {
        cred_l1 = "Designed, written and developed by \n \n" + "Daniel Robertson"
        cred_l2 = "Audio by Gumbell \n \n" + "Licensed under the Creative Commons Attribution License"
        cred_l3 = "Typeface created by Jayvee D. Enaguas \n \n" + "Licensed under Creative Commons (CC-BY-NC-SA 3.0) \n \n"
        cred_l4 = "Special thanks to \n \n" + "Joe Benton \n George Grover \n Joel Trew \n Arne Bahlo \n Thuong Nguyen \n Paul Hudson"
        charSets = [cred_l1,cred_l2,cred_l3,cred_l4]
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.09, target: self, selector: #selector(CreditsViewController.addNextLetter), userInfo: nil, repeats: true)
        timer!.fire()
    }

    func addNextLetter() {
        let currentText = charSets[activeLine]
        var charArray = Array(currentText.characters)
        
        if creditsText.text!.characters.count >= charArray.count {
            timer?.invalidate()
            sleep(1)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.06, target:self, selector: #selector(CreditsViewController.removePreviousLetter), userInfo: nil, repeats: true)
            timer!.fire()
        } else {
            let nextLetterIndex = creditsText.text!.characters.count
            let character = charArray[nextLetterIndex]
            creditsText.text = creditsText.text! + String(character)
        }
    }
    
    func removePreviousLetter() {
        if creditsText.text!.characters.count == 0 {
            timer?.invalidate()
            
            activeLine += 1
            if activeLine == charSets.count {
                sleep(2)
                self.navigationController?.popToRootViewControllerAnimated(true)
            } else {
                sleep(1)
                typeStart()
            }
        } else {
            let newText = String(creditsText.text.characters.dropLast())
            creditsText.text = newText
        }
    }
    
    @IBAction func backToMenu(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
