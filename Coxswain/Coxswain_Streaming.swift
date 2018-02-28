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
        player.play()
    }
}
