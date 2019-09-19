//
//  PasscodeService.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/18/19.
//  Copyright © 2019 huy. All rights reserved.
//

class PasscodeService {
    
    // MARK: - Constants
    struct Constants {
        static let keyPasscode = "passcode"
        static let passcodeMode = "turnOnPasscode"
    }
    
    // MARK: - Singleton
    static let shared = PasscodeService()
    
    // MARK: - Support Method
    func checkExistPasscode() -> Bool {
        if let _ = UserDefaults.standard.string(forKey: Constants.keyPasscode) {
            return true
        }
        return false
    }
    
    func checkTurnOnPasscode() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.passcodeMode)
    }
    
    func addNewPasscode(newPasscode: String) {
        UserDefaults.standard.setValue(newPasscode, forKey: Constants.keyPasscode)
    }
    
    func checkRightPasscode(inputPasscode: String) -> Bool {
        guard let passcode = UserDefaults.standard.string(forKey: Constants.keyPasscode) else {
            return false
        }
        if inputPasscode == passcode {
            return true
        }
        return false
    }
    
    func turnOnPasscodeMode(turnOn: Bool) {
        UserDefaults.standard.set(turnOn, forKey: Constants.passcodeMode)
    }
}
