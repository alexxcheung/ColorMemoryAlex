//
//  AppDelegate.swift
//  ColorMemory
//
//  Created by Alex Cheung on 25/11/2019.
//  Copyright © 2019 Alex Cheung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(rank.rankList), forKey:"rankList")
    }
    // MARK: UISceneSession Lifecycle

}

