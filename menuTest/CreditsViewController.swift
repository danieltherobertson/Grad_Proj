//
//  CreditsViewController.swift
//  menuTest
//
//  Created by Daniel Robertson on 08/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var creditsText: UITextView!
    
    var cred_l1 = String!()
    var cred_l2 = String!()
    var cred_l3 = String!()
    
    var charSets: Array<String>!
    var charArray: Array<Character>!

    var timer: NSTimer?
    var activeLine = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        creditsText.textColor = UIColor.greenColor()
    
        
        // Do any additional setup after loading the view.
    }
    
    func typeStart() {
      
        cred_l1 = "Designed, written and developed by \n" + "Daniel Robertson \n \n"
        cred_l2 = "Audio by Gumbell \n" + "Licensed under the Creative Commons Attribution License \n \n"
        cred_l3 = "Typeface created by Jayvee D. Enaguas \n" + "Licensed under Creative Commons (CC-BY-NC-SA 3.0)"
        
        charSets = [cred_l1,cred_l2,cred_l3]
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.09, target: self, selector: #selector(CreditsViewController.addNextLetter), userInfo: nil, repeats: true)
        timer!.fire()
    }
    
    
    func addNextLetter() {
        
        var currentText = charSets[activeLine]
        var charArray = Array(currentText.characters)
        
        if creditsText.text!.characters.count >= charArray.count {
            timer?.invalidate()
        } else {
            let nextLetterIndex = creditsText.text!.characters.count
            let character = charArray[nextLetterIndex]
            creditsText.text = creditsText.text! + String(character)
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target:self, selector: #selector(CreditsViewController.wait), userInfo: nil, repeats: false)
        timer!.fire()
    }
    
    func wait() {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.09, target:self, selector: #selector(CreditsViewController.removeNextLetter), userInfo: nil, repeats: false)
        timer!.fire()
    }
    
    func removeNextLetter() {
        if creditsText.text!.characters.count <= charArray.count {
            timer?.invalidate()
        }
    }
}
