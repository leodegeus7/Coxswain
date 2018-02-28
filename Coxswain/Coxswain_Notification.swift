//
//  Coxswain_Notification.swift
//  Coxswain
//
//  Created by Leonardo Geus on 27/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit

extension Coxswain {
    func postNotification(name:String) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "coxwain-\(name)"), object: nil)
    }
    
}
