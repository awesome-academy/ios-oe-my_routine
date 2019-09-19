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
        setUpKeyboard()
        return true
    }
    
    func setUpKeyboard() {
        IQKeyboardManager.shared.enable = true
    }
    
    func checkPassCode() {
        if PasscodeService.shared.checkTurnOnPasscode(), PasscodeService.shared.checkExistPasscode() {
            let controller = PasswordInputContrroller.instantiate()
            controller.typeOfInputPasscode = .inputPasscode
            UIViewController.top()?.present(controller, animated: true, completion: nil)
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        checkPassCode()
    }
    
}
