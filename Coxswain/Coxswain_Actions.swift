//
//  Coxswain_Actions.swift
//  Coxswain
//
//  Created by Leonardo Geus on 26/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit

extension Coxswain {
    internal func findActionsInText(text:String) -> ([ActionEntry],String?) {
        let firstSplit = text.split(separator: "{")
        var texts:[String] = []
        var characterIndexes:[Int] = []
        var namesString:[String] = []
        var isFirstEntry = true
        for first in firstSplit {
            let secondSplit = first.split(separator: "}")
            let code = secondSplit.first!
            
            characterIndexes.append(texts.joined().count)
            if secondSplit.count > 1 {
                let restOfString = secondSplit[1]
                texts.append(String(restOfString))
                namesString.append(String(code))
            } else {
                if isFirstEntry {
                    let restOfString = secondSplit[0]
                    texts.append(String(restOfString))
                    characterIndexes.remove(at: 0)
                } else {
                    namesString.append(String(code))
                }
            }
            isFirstEntry = false
        }
        let finalText = String(texts.joined())
        let percents:[Float] = characterIndexes.map {Float($0) / Float(finalText.count)}
        var actions = [ActionEntry]()
        if namesString.count == percents.count {
            zip(namesString, percents).forEach {
                actions.append(ActionEntry(name: $0, percent: Float($1)))
            }
        }
        return (actions,finalText)
    }
    
}
