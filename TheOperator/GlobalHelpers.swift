//
//  GlobalHelpers.swift
//  TheOperator
//
//  Created by Daniel Robertson on 19/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func secondsToHoursMinutesSeconds (seconds : Int) -> String {
    let secondsRaw = (seconds % 3600) % 60
    var secondsConverted = String()
    if secondsRaw < 10 {
        secondsConverted = "0\(secondsRaw)"
        return "0\(((seconds % 3600) / 60)):\(secondsConverted)"
    } else {
        return "0\(((seconds % 3600) / 60)):\((seconds % 3600) % 60)"
    }
}

func timeToInt(time: String) -> Int{
    var numOfSec = Int()
    var timeCharacters = Array(time.characters)
    //REMOVING COLON
    for (index, character) in timeCharacters.enumerate() {
        if character == ":" {
            timeCharacters.removeAtIndex(index)
        }
    }
    //GETTING NUMBER OF MINUTES, THE SECOND CHARACTER IN STRING
    let secChar = String(timeCharacters[1])
    let secInt = Int(secChar)
    
    //IF THERE IS 0 MINUTES, REMOVES THE FIRST TWO DIGITS TO BE LEFT WITH NUMBER OF SECONDS
    //OR, REMOVES THE FIRST 0 AND THEN GETS THE SECONDS
    if timeCharacters.count == 4 && secInt == 0 {
        timeCharacters.removeAtIndex(0)
        timeCharacters.removeAtIndex(0)
        let sec1 = String(timeCharacters[0])
        let sec2 = String(timeCharacters[1])
        numOfSec = Int(sec1)!+Int(sec2)!
    } else {
        timeCharacters.removeAtIndex(0)
        let sec1 = String(timeCharacters[1])
        let sec2 = String(timeCharacters[2])
        numOfSec = Int(sec1+sec2)!
    }
    //MULTIPLES NUMBER OF MINUTES BY 60 TO GET THE NUMBER OF SECONDS THE MINUTES EQUATE TO
    let numOfMin = secInt!*60
    //COMBINES THE SECONDS AND THE MINUTES CONVERTED TO SECONDS
    let timeInSeconds = numOfMin+numOfSec
    print(timeInSeconds)
    return timeInSeconds
}

func calculateTimeScore(totalTime: Int, timeLeft: Int) -> Int {
    let timeRemaining = totalTime-timeLeft
    return timeRemaining
}
