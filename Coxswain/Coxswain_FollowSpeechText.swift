//
//  Coxwain_FollowSpeechText.swift
//  Coxswain
//
//  Created by Leonardo Geus on 26/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit

extension Coxswain {
    
    enum Direction {
        case Left
        case Right
    }
    
    func printActualWordInAudio(actualSecond:Float,duration:Float,text:String) {
        let string = getActualWord(actualSecond: Float(actualSecond), duration: Float(duration), text: text)
        if lastPrintedWord != string {
            print(string)
            lastPrintedWord = string
        }
    }
    
    func getActualWord(actualSecond:Float,duration:Float,text:String) -> String {
        if totalText == nil {
            totalText = text
        }
        let percent = actualSecond/duration
        let characterCount = text.count
        let possibleCharacterIndex = Float(characterCount) * percent
        if possibleCharacterIndex >= Float((totalText?.count)!) {
            return ""
        }
        if String(Array(text)[Int(possibleCharacterIndex)]) == " " {
            return " "
        }
        
        var index = -1
        var leftText = ""
        index = Int(possibleCharacterIndex)
        
        while thereIsCharacter(direction: .Left, text: text, indexOfCharacter: Int(index)) {
            leftText = leftText + String(Array(text)[Int(index-1)])
            index = index-1
        }
        leftText = String(leftText.reversed())
        
        var rightText = ""
        index = Int(possibleCharacterIndex)
        while thereIsCharacter(direction: .Right, text: text, indexOfCharacter: Int(index)) {
            rightText = rightText + String(Array(text)[Int(index+1)])
            index = index+1
        }
        return leftText + String(Array(text)[Int(possibleCharacterIndex)]) + rightText
    }
    
    func thereIsCharacter(direction:Direction,text:String,indexOfCharacter:Int) -> Bool {
        switch direction {
        case .Left:
            if indexOfCharacter - 1 < 0 {
                return false
            } else {
                let character = String(Array(text)[Int(indexOfCharacter-1)])
                if character == " " {
                    return false
                } else {
                    return true
                }
            }
        case .Right:
            if indexOfCharacter + 1 > text.count-1 {
                return false
            } else {
                let character = String(Array(text)[Int(indexOfCharacter+1)])
                if character == " " {
                    return false
                } else {
                    return true
                }
            }
        }
    }
}
