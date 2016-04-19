//
//  GameViewController.swift
//  menuTest
//
//  Created by Daniel Robertson on 17/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var gameView: GameView!
    var tutorialDialogue = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTutorial()
        
        let dialogue1 = String(tutorialDialogue[0].valueForKey("text")!)
        gameView.gameText.textColor = UIColor.blackColor()
       // gameView.gameText.font = UIFont(name: "KemcoPixelBold", size: 11)
        gameView.gameText.text = (dialogue1)
        gameView.gameAnswerOne.setTitle("Jack", forState: .Normal)
        gameView.gameAnswerTwo.setTitle("Gene Parmesan", forState: .Normal)
        gameView.gameAnswerThree.setTitle("Gordon", forState: .Normal)
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTutorial() -> [NSDictionary] {
        var results = [NSDictionary]()
        
        if let path = NSBundle.mainBundle().pathForResource("TutorialDialogue", ofType: "json") {
            do {
                //Tries to convert the json to NSData
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                //If that works, it serialises the json into a dictionary called jsonResult
                do {
                    let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        print("ron")
                    //If that works, we create an array of dictionaries excepting a string as a key and an any object as its value
                    if let dialogues = jsonResult["tutorialDialogues"] as? [[String: AnyObject]] {
                        print("jess")
                        for dialogue: [String: AnyObject] in dialogues {
                            print("callum")
                            results.append(dialogue)
                        }
                    }
                } catch {}
            } catch {}
        }
     //   Returns our juicy data in a lovely array of dictionaries
                print("doot doot\(results)")
               // print("TRYING \(results[0])")
                //print("TRYING AGAIN \(results[2])")
                print("NUMBER OF ??? IS \(results.count)")
        tutorialDialogue = results
        return results
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
