//
//  scoreCalculator.swift
//  TheOperator
//
//  Created by Daniel Robertson on 21/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation

func dispatchConverter(units: [String]) -> String {
    var service1 = ""
    var service2 = ""
    var service3 = ""
    
    var servicesFiltered = [String]()
    
    for unit in units {
        if unit == "Police" {
            servicesFiltered.append("Police")
        } else if unit == "Ambulance" {
            servicesFiltered.append("Ambulance")
        } else if unit == "Fire Brigade" {
            servicesFiltered.append("Fire Brigade")
        }
    }

    
    for (index, item) in servicesFiltered.enumerate() {
        if index == 0 {
            service1 = item
        }
        if index == 1 {
            service2 = item
        }
        if index == 2 {
            service3 = item
        }
    }
    
    var dispatchedString = ""
    if service2 == "" && service3 == "" {
        dispatchedString = "\(service1)"
    }
    if service3 == "" && service1 != "" && service2 != "" {
        dispatchedString = "\(service1) and \(service2)"
    }
    if service3 != "" && service2 != "" && service1 != "" {
        dispatchedString = "\(service1), \(service2) and \(service3)"
    }


    return dispatchedString
}

func servicesStringToInt(services: String) -> [Int] {
    let servicesCut = services.componentsSeparatedByString(" ")
    var servicesConvert = [Int]()
    for (_, word) in servicesCut.enumerate() {
        if word == "Police"  {
            servicesConvert.append(0)
        }
        if word == "Ambulance" {
            servicesConvert.append(1)
        }
        if word == "Fire" {
            servicesConvert.append(2)
        }
    }
    return servicesConvert
}

func generateHeadline (dispatchedServices: [Int], requiredServices: [String], headlines: [NSDictionary]) -> String {
    var dispatchedServicesString = [String]()
    var wrongServices = [String]()
    var rightServices = [String]()
    var missingServices = [String]()
    var service1 = [String]()
    var service2 = [String]()
    var service3 = [String]()
    var failHeadlines = [String]()
    var passHeadlines = [String]()
    
    //Convert dispatched services to strings
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
    
    //Getting the ifFails and ifPresent headlines for each requiredService, seperating them out into Police headlines, Ambulance headlines and Fire headlines
    for item in headlines {
        if let serviceToDispatch = item.valueForKey("service") as? String {
            // print(serviceToDispatch)
            if let ifFails = item.valueForKey("ifFails") as? String {
                if let ifPresent = item.valueForKey("ifPresent") as? String {
                    if let critical = item.valueForKey("isCritical") as? String {
                        if serviceToDispatch == "Police" {
                            service1.append(serviceToDispatch); service1.append(ifFails); service1.append(ifPresent); service1.append(critical)
                        }
                        if serviceToDispatch == "Ambulance" {
                            service2.append(serviceToDispatch); service2.append(ifFails); service2.append(ifPresent); service2.append(critical)
                        }
                        if serviceToDispatch == "Fire Brigade" {
                            service3.append(serviceToDispatch); service3.append(ifFails); service3.append(ifPresent); service3.append(critical)
                        }
                    }
                }
            }
        }
    }
    
    //Finding the headlines that match to each missing and correct service, adding those headlines to an array of fail headlines and an array of pass headLines
    for missingService in missingServices {
        if missingService == service1.first {
            failHeadlines.append(service1[1])
            failHeadlines.append(service1[3])
        }
        if missingService == service2.first {
            failHeadlines.append(service2[1])
            failHeadlines.append(service2[3])
        }
        if missingService == service3.first {
            failHeadlines.append(service3[1])
            failHeadlines.append(service3[3])
        }
    }
    
    for rightService in rightServices {
        if rightService == service1.first {
            passHeadlines.append(service1[2])
            passHeadlines.append(service1[3])
        }
        if rightService == service2.first {
            passHeadlines.append(service2[2])
            passHeadlines.append(service2[3])
        }
        if rightService == service3.first {
            passHeadlines.append(service3[2])
            passHeadlines.append(service3[3])
        }
    }
    
    var eventPosition = Int()
    var event = String()
    var eventIsInPass = Bool()
    
    for (index, headline) in passHeadlines .enumerate(){
        if headline == "true" {
            eventIsInPass = true
            eventPosition = index-1
        }
    }
    
    for (index, headline) in failHeadlines .enumerate(){
        if headline == "true" {
            eventIsInPass = false
            eventPosition = index-1
        }
    }
    if eventIsInPass {
        for (index, headline) in passHeadlines .enumerate(){
            if index == eventPosition {
                event = headline
            }
        }
    } else {
        for (index, headline) in failHeadlines .enumerate(){
            if index == eventPosition {
                event = headline
            }
        }
    }
    return event
}

func timeToInt(time: String) -> Int{
    var numOfSec = String()
    var numOfSecInt = Int()
    let time2 = time.stringByReplacingOccurrencesOfString("Time ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    
    var timeCharacters = Array(time2.characters)
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
        numOfSec = sec1+sec2
        numOfSecInt = Int(numOfSec)!
    } else {
        timeCharacters.removeAtIndex(0)
        let sec1 = String(timeCharacters[1])
        let sec2 = String(timeCharacters[2])
        numOfSec = sec1+sec2
        numOfSecInt = Int(numOfSec)!
    }
    //MULTIPLES NUMBER OF MINUTES BY 60 TO GET THE NUMBER OF SECONDS THE MINUTES EQUATE TO
    let numOfMin = secInt!*60
    //COMBINES THE SECONDS AND THE MINUTES CONVERTED TO SECONDS
    let timeInSeconds = numOfMin+numOfSecInt
   // print(timeInSeconds)
    return timeInSeconds
}


func calculateTimeScore(startingTime: Int, timeLeft: Int) -> [Int] {
    //PART 1
    let increment = startingTime/10
    //To get the score, we divide the total time by 10 to scale down values e.g 120 seconds/10 = 12. To get the player's remaining time score (the bit on the left side of '...out of...'), If the player has 31 seconds, we need to scale that down proportionally to the total score. This is done by calculating the number of times one tenth of the total score can be mltipled into the remaining time e.g 12*3 is 36, that's the multiple of 12 closest to 36. So we know they got 3 out of 12. This is done as it converts the remaining time into a whole number that is also a multiple of the total time.If this wasn't done, the score would be 3.1/12. The total time is halved as a level shouldn't be beatable in under half the time so the score is done based on how much of half the time remains, so it becomes 3 out of 6. Both sides of the score are then multiplied by 5 to upscale a bit, so it becomes 15/30.
    var scoreTime = nearestIndex(increment, remainingTime: timeLeft, totalTime: startingTime)
    let finalTime = totalTimeConverter(startingTime)
    if scoreTime > finalTime {
        scoreTime = finalTime
    }
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
    
   // print(remainingTime)
   // print(increment)
   // print(totalTime)
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
              //  print("score time = \(scoreTime)")
                 break
            }
        }
    }
    getScale()
   // print("INDEX MULTIPLE \(indexMultiple)")
    checkTime()
   // print(scoreTime)
    return scoreTime
}

func totalTimeConverter(startingTime: Int) -> Int {
    //PART 3
   // print("start time: \(startingTime)")
   let timeHalf = startingTime/2
   // print("half time: \(timeHalf)")
    let timeFormat = timeHalf/10
    //print("time format: \(timeFormat)")
    let finalTime = timeFormat*5
   // print("final time: \(finalTime)")
    return finalTime
}

func calculateDispatchScore (dispatchedServices: [Int], requiredServices: [String]) -> [Int] {
    var dispatchedServicesString = [String]()
    var wrongServices = [String]()
    var rightServices = [String]()
    var missingServices = [String]()
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
    
    let scoreOutOf = requiredServices.count*10
    var playerScore = Int()
    
    if rightServices.count == requiredServices.count {
        playerScore = scoreOutOf
    } else {
        playerScore = rightServices.count*10
    }
    
    print("playerScore is \(playerScore)")
    
    for _ in wrongServices {
        penalty += 5
    }
    
    for _ in missingServices {
        penalty += 5
    }
    let finalScore = playerScore-penalty
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

func calculateRank(startingTime: Int, remainingTime: String, dispatchedServices: [Int], requiredServices: [String]) -> String {
    let totalScore = calculateScore(startingTime, remainingTime: remainingTime, dispatchedServices: dispatchedServices, requiredServices: requiredServices)
    let outOf = totalScore[1]
    let quarterScore = outOf/4
    let playerScore = totalScore[0]
    var playerRank = String()
    
    if playerScore <= quarterScore {
        playerRank = "Recruit"
    }
    
    if playerScore <= quarterScore*2 && playerScore > quarterScore {
        playerRank = "Rookie"
    }
    
    if playerScore <= quarterScore*3 && playerScore > quarterScore*2{
        playerRank = "Sweet Talker"
    }
    
    if playerScore <= outOf && playerScore > quarterScore*3 {
        playerRank = "Telephone Hero"
    }
    print(playerRank)
    return playerRank
}