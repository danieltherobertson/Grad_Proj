//
//  LevelReviewViewController.swift
//  TheOperator
//
//  Created by Daniel Robertson on 18/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import UIKit

class LevelReviewViewController: UIViewController {

    @IBOutlet weak var reviewText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let feedback = ""
        reviewText.typeStart(feedback)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
