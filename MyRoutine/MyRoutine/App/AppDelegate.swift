//
//  AppDelegate.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 7/31/19.
//  Copyright © 2019 huy. All rights reserved.
//

import IQKeyboardManagerSwift
import UserNotifications
import LocalAuthentication

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUpKeyboard()
        setupPushNotification()
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
       checkPassCode()
    }
    
    private func setUpKeyboard() {
        IQKeyboardManager.shared.enable = true
    }
    
    func checkPassCode() {
        if PasscodeService.shared.checkTurnOnPasscode(), PasscodeService.shared.checkExistPasscode() {
            let controller = PasswordInputContrroller.instantiate()
            controller.typeOfInputPasscode = .inputPasscode
            UIViewController.top()?.present(controller, animated: true, completion: nil)
        }
    }
    
    private func setupPushNotification() {
        UNUserNotificationCenter.current().delegate = self
        NotificationSerivce.shared.registerPushNotification()
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
