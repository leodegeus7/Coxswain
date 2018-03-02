//
//  Coxswain.swift
//  Coxswain
//
//  Created by Leonardo Geus on 26/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import AVFoundation
import UIKit

internal struct ActionEntry {
    var name:String
    var percent:Float
}

public protocol CoxswainDelegate: class {
    func didFoundedActionInSpeech(actionText:String)
}

public class Coxswain: NSObject {
    public weak var delegate: CoxswainDelegate?
    
    public static let shared = Coxswain()
    
    var player : AVPlayer!
    var timer:Timer!
    var text = ""
    var totalDuration = -1.0
    var streamingLink:String? = nil
    var lastPrintedWord = ""
    var totalString:String? = nil
    var totalText:String? = nil
    var finalString:String? = nil
    var waveform:WaveformView!
    var actionEntries = [ActionEntry]()
    
    var actualRate = 0.0
    var streamingStatus:AudioStatus = .Off {
        didSet {
            print(streamingStatus)
        }
    }
    
    public func initialize(textToSpeech:String,voice:Voice) -> Coxswain {
        initialConfig()
        text = textToSpeech
        //timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerCycle), userInfo: nil, repeats: true)
        
        (actionEntries,finalString) = findActionsInText(text: textToSpeech)
        actionsPassed = actionEntries
        sendText(text: finalString!,voice: voice) { (id) in
            self.getLink(id: id!) { (string) in
                if let link = string {
                    print(link)
                    self.streamingLink = link
                } else {
                    print("Didn't find link")
                }
            }
        }
        return self
    }
    
    internal override init() {
        super.init()
    }
    
    public func initialize(idToSpeech:String,textToSpeech:String) -> Coxswain {
        initialConfig()
        text = textToSpeech
        //timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerCycle), userInfo: nil, repeats: true)
        
        (actionEntries,finalString) = findActionsInText(text: textToSpeech)
        actionsPassed = actionEntries
        getLink(id: idToSpeech) { (string) in
            if let link = string {
                print(link)
                self.streamingLink = link
            } else {
                print("Didn't find link")
            }
        }
        return self
    }
    
    @objc internal func timerCycle() {
        DispatchQueue.main.async {
            if let _ = self.player {
                self.totalDuration = (self.player.currentItem?.duration.seconds)!
                if self.streamingStatus == .Off { self.streamingStatus = .Loading}
                if self.player.currentTime().seconds > 0 {
                    if self.streamingStatus == .Loading { self.streamingStatus = .Running}
                    //self.printActualWordInAudio(actualSecond: Float(self.player.currentTime().seconds), duration: Float((self.player.currentItem?.duration.seconds)!), text: self.finalString!)
                    self.actualRate = Double(self.player.rate)
                    if self.player.currentTime().seconds >= self.totalDuration {
                        self.timer.invalidate()
                        if self.streamingStatus == .Running { self.streamingStatus = .Finished}
                        self.updateLevel()
                        self.player.pause()
                        return
                    }
                    self.updateLevel()
                    let actualPercent = Float(self.player.currentTime().seconds)/Float((self.player.currentItem?.duration.seconds)!)
                    if let action = self.identifyActions(actualPercent: actualPercent,actions:self.actionsPassed) {
                        self.delegate?.didFoundedActionInSpeech(actionText: action.name)
                        self.postNotification(name:action.name)
                    }
                }
            }
        }
    }
    
    var actionsPassed = [ActionEntry]()
     
    private func identifyActions(actualPercent:Float,actions:[ActionEntry]) -> ActionEntry? {
        if let first = actionsPassed.first {
            if first.percent < actualPercent {
                actionsPassed.remove(at: 0)
                return first
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    
    public func addWaveform(view:WaveformView) {
        self.waveform = view
        view.backgroundColor = UIColor.clear
        waveform.updateWithLevel(0)
    }
    
    func updateLevel() {
        if self.streamingStatus == .Running {
            let random = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
            waveform.updateWithLevel(CGFloat(random))
        } else if streamingStatus == .Finished {
            waveform.updateWithLevel(0)
        }
    }
    
    var tries = 0
    public func play() {
        if let _ = streamingLink {
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerCycle), userInfo: nil, repeats: true)
            self.streamingAudio(url: streamingLink!)
        } else {
            sleep(1)
            tries = tries + 1
            if tries < 30 {
                play()
            } else {
                print("Failed to play audio")
            }
        }
    }
    
    public enum Voice : String {
        case PtBrMale = "Ricardo"
        case PtBrFemale = "Vitoria"
        case USMale = "Joey"
        case USFemale = "Joanna"
    }
    
    private func initialConfig() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func sendText(text:String,voice:Voice,completion: @escaping (_ result: String?) -> Void) {
        let url = URL(string: "https://vuodze1pmc.execute-api.us-east-1.amazonaws.com/dev")!
        let parameters = ["text": text, "voice": voice.rawValue] as [String : String]
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = String(data: data, encoding: String.Encoding.utf8) {
                    print(json)
                    let teste = json.replacingOccurrences(of: "\\", with: "")
                    let teste2 = teste.replacingOccurrences(of: "\"", with: "")
                    completion(teste2)
                }
            }
        })
        task.resume()
    }
    
    func getLink(id:String,completion: @escaping (_ result: String?) -> Void) {
        sleep(1)
        let url = URL(string: "https://vuodze1pmc.execute-api.us-east-1.amazonaws.com/dev/?postId=\(id)")!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    if json.count > 0 {
                        let dic:[String:String] = json.first! as! [String:String]
                        if dic["url"] != nil {
                            completion(dic["url"])
                        } else {
                            self.getLink(id: id, completion: { (result2) in
                                completion(result2)
                            })
                        }
                    } else {
                        completion(nil)
                    }
                    
                } else {
                    completion(nil)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
}
