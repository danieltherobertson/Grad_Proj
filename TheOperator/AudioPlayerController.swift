//
//  AudioPlayer.swift
//  TheOperator
//
//  Created by Daniel Robertson on 10/05/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayerController: NSObject {
    var audioPlayer: AVAudioPlayer!
    
    static let sharedInstance = AudioPlayerController()
    
    func startAudio(audio: String) {
        
        let audio = NSURL (fileURLWithPath: NSBundle.mainBundle().pathForResource(audio, ofType: "mp3")!)
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: audio)
        self.fadeIn(nil)
        audioPlayer.numberOfLoops = -1
    }
    
    func stopAudio() {
        if audioPlayer.playing {
            audioPlayer.stop()
        }
    }
    
    func fadeOut(completion: ( ()->())? ) {
        if audioPlayer.volume > 0.1 {
            audioPlayer.volume -= 0.035
            let triggerTime = Int64(0.2 * Double(NSEC_PER_SEC))
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { 
                self.fadeOut(completion)
            })
        } else {
            audioPlayer.stop()
            audioPlayer.volume = 1
            audioPlayer.currentTime = 0
            if let completion = completion {
                completion ()
            }
        }
    }
    
    func fadeIn(completion: ( ()->())? ) {
        
        if audioPlayer.playing {
            if audioPlayer.volume < 0.8 {
                audioPlayer.volume += 0.02
                let triggerTime = Int64(0.5 * Double(NSEC_PER_SEC))
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), {
                    self.fadeIn(completion)
                })
            } else {
                if let completion = completion {
                    completion ()
                }
            }
        } else {
            audioPlayer.volume = 0
            audioPlayer.currentTime = 0
            audioPlayer.play()
            self.fadeIn(completion)
        }
    }
}