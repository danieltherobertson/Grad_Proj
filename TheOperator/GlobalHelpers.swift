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
   // print(timeInSeconds)
  //  print("\(timeInSeconds) seconds out of 180")
    return timeInSeconds
}


func calculateTimeScore(startingTime: Int, timeLeft: Int) -> [Int] {
    //PART 1
    let increment = startingTime/10
    //To get the score, we divide the total time by 10 to scale down values e.g 120 seconds/10 = 12. To get the player's remaining time score (the bit on the left side of '...out of...'), If the player has 31 seconds, we need to scale that down proportionally to the total score. This is done by calculating the number of times one tenth of the total score can be mltipled into the remaining time e.g 12*3 is 36, that's the multiple of 12 closest to 36. So we know they got 3 out of 12. This is done as it converts the remaining time into a whole number that is also a multiple of the total time.If this wasn't done, the score would be 3.1/12. The total time is halved as a level shouldn't be beatable in under half the time so the score is done based on how much of half the time remains, so it becomes 3 out of 6. Both sides of the score are then multiplied by 5 to upscale a bit, so it becomes 15/30.
    let scoreTime = nearestIndex(increment, remainingTime: timeLeft, totalTime: startingTime)
    let finalTime = totalTimeConverter(startingTime)
    let playerTimeScoreRead = "equals \(scoreTime) out of \(finalTime) points"
    
   // print(playerTimeScoreRead)
    let playerTimeScore = [scoreTime,finalTime]
    return playerTimeScore
}

func nearestIndex(increment: Int, remainingTime: Int, totalTime: Int) -> Int {
    //PART 2
    let incrementLocal = increment
    let remainingTimeLocal = remainingTime
    var indexMultiple = 1
    var scale = [Int]()
    var sum = incrementLocal*indexMultiple
    var scoreTime = Int()
    var reperform = false
    
    //FIGURE OUT A SCALE WHERE EACH VALUE IS A MULTIPLE OF INCREMENT, WHICH IS THE REMAINING TIME DIVIDED BY 10.
    func getScale() {
        repeat {
            let scaleValue = indexMultiple*incrementLocal
            scale.append(scaleValue)
            indexMultiple += 1
        } while scale.last < totalTime
    }
    
    func checkTime() {
        let localRange = incrementLocal/2
        for (index,number) in scale.enumerate() {
            if number+localRange >= remainingTimeLocal && number-localRange <= remainingTimeLocal {
                let indexRead = index+1
                scoreTime = indexRead*5
                break
            }
        }
    }
    getScale()
    checkTime()
    return scoreTime
}

func totalTimeConverter(startingTime: Int) -> Int {
    //PART 3
    let timeHalf = startingTime/2
    let timeFormat = timeHalf/10
    let finalTime = timeFormat*5
    return finalTime
}

func calculateDispatchScore (dispatchedServices: [Int], requiredServices: [String]) -> [Int] {
    var dispatchedServicesString = [String]()
    var wrongServices = [String]()
    var rightServices = [String]()
    var missingServices = [String]()
    var servicesWrong = 0
    var penalty = 0

    for service in dispatchedServices {
        if service == 0 {
            dispatchedServicesString.append("Police")
        } else if service == 1 {
            dispatchedServicesString.append("Ambulance")
        } else if service == 2 {
            dispatchedServicesString.append("Fire Brigade")
        }
    }
    
    for requiredService in requiredServices {
        for dispatchedService in dispatchedServicesString {
            if dispatchedServicesString.contains(requiredService) == false && missingServices.contains(requiredService) == false {
                missingServices.append(requiredService)
            }
            if dispatchedServicesString.contains(requiredService) && rightServices.contains(requiredService) == false {
                rightServices.append(requiredService)
            }
            if requiredServices.contains(dispatchedService) == false && wrongServices.contains(dispatchedService) == false {
                wrongServices.append(dispatchedService)
            }
        }
    }
    
//    print("The one we got right: \(rightServices)")
//    print("The ones we got wrong: \(wrongServices)")
//    print("The ones we're missing: \(missingServices)")
    
    var scoreOutOf = requiredServices.count*10
    var playerScore = Int()
    
    if rightServices.count == requiredServices.count {
        playerScore = scoreOutOf
    } else {
        playerScore = rightServices.count*10
    }
    
    for service in wrongServices {
        penalty += 5
    }
    
    for service in missingServices {
        penalty += 5
    }
    var finalScore = playerScore-penalty
    var dispatchScoreRead = "\(finalScore) out of \(scoreOutOf) points"
   // print(dispatchScoreRead)
    let dispatchScore = [finalScore,scoreOutOf]
    return dispatchScore
}

func calculateTotalScore(timeScore: [Int], dispatchScore: [Int]) -> [Int] {
    let totalPossibleScore = timeScore[1]+dispatchScore[1]
    let totalPlayerScore = timeScore.first!+dispatchScore.first!
    let totalScore = [totalPlayerScore,totalPossibleScore]
    
    return totalScore
}

func calculateScore(startingTime: Int, remainingTime: String, dispatchedServices: [Int], requiredServices: [String]) -> [Int] {
    let convertedTime = timeToInt(remainingTime)
    let timeScore = calculateTimeScore(startingTime, timeLeft: convertedTime)
    let dispatchScore = calculateDispatchScore(dispatchedServices, requiredServices: requiredServices)
    let totalScore = calculateTotalScore(timeScore, dispatchScore: dispatchScore)
    
    print("We got \(totalScore[0]) out of \(totalScore[1])")
    return totalScore
}

