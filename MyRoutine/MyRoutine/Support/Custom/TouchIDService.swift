//
//  TouchIDService.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/19/19.
//  Copyright © 2019 huy. All rights reserved.
//

import LocalAuthentication

class TouchIDService {
    
    struct Constants {
        static let reasonString = "Sử dụng TouchID để sử dụng App"
        static let touchIDKey = "touchID"
    }
    
    // MARK: - Singleton
    static let shared = TouchIDService()
    
    // MARK: - Support Method
    func authenticateUserTouchID(completion: @escaping (Bool) -> Void) {
        let context: LAContext = LAContext()
        let myLocalizedReasonString = Constants.reasonString
        var authError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: myLocalizedReasonString) { success, _ in
                completion(success)
            }
        }
    }
    
    func checkTurnOnTouchID() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.touchIDKey)
    }
    
    func turnOnTouchID(turnOn: Bool) {
        UserDefaults.standard.set(turnOn, forKey: Constants.touchIDKey)
    }
}
