//
//  AppDelegate.swift
//  DemoApp
//
//  Created by Leonardo Geus on 26/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Coxswain

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func didFoundedActionInSpeech(actionText: String) {
//        print(actionText)
//        switch actionText {
//        case "diler":
//            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
//
//            appearLabel(label: labelTitle)
//            break
//        case "1":
//            appearLabel(label: labelOne)
//            break
//        case "2":
//            appearLabel(label: labelTwo)
//            break
//        case "3":
//            appearLabel(label: labelThree)
//            break
//        case "4":
//            appearLabel(label: labelFour)
//            break
//        case "waveform":
//            UIView.animate(withDuration: 0.5) {
//                self.waveForm.alpha = 1
//            }
//            break
//        case "changeBackground":
//            changeBackground()
//        case "changeBackground2":
//            changeBackground2()
//        case "changeBackground3":
//            changeBackground2()
//        case "end":
//            performSegue(withIdentifier: "segueToOne", sender: self)
//            break
//        default:
//            break
//        }
//    }

}

