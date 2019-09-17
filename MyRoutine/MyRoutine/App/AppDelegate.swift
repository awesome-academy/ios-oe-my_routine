//
//  AppDelegate.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 7/31/19.
//  Copyright © 2019 huy. All rights reserved.
//

import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        return true
    }
    
}
