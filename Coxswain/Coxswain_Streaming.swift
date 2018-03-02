//
//  Coxswain_Streaming.swift
//  Coxswain
//
//  Created by Leonardo Geus on 26/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import AVFoundation

extension Coxswain {
    enum AudioStatus {
        case Off
        case Running
        case Loading
        case Finished
    }
    
    func streamingAudio(url:String) {
        player = AVPlayer(url: URL(string: url)!)
        player.volume = 1.0
        player.rate = 1.0
    }
    
    public func resumeSpeech() {
        if let _ = streamingLink {
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerCycle), userInfo: nil, repeats: true)
            player.playImmediately(atRate: Float(actualRate))
        } else {
            sleep(1)
            tries = tries + 1
            if tries < 30 {
                resumeSpeech()
            } else {
                print("Failed to play audio")
            }
        }
        
    }
    

    
    public func pause() {
        if player.rate != 0 && player.error == nil {
            player.pause()
            timer.invalidate()
            timer = nil

        }
    }
}
