//
//  AlertViewControl.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class AlertViewControl {
    
    static func showQuickSystemAlert(title: String? = nil,
                                     message: String? = nil,
                                     cancelButtonTitle: String = "OK",
                                     handler: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert).then {
            $0.addAction(UIAlertAction(title: cancelButtonTitle,
                                       style: .cancel,
                                       handler: { _ in
                                       handler?()
            }))
        }
        UIViewController.top()?.present(alertVC, animated: true)
    }
    
    static func showInputAlert(title: String? = nil, message: String? = nil,
                               cancelButtonTitle: String = "OK",
                               inputType: UIKeyboardType = UIKeyboardType.default,
                               placeHolder: String = "",
                               saveButtonTitle: String,
                               handler: ((String) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert).then {
            var inputTextfield = UITextField()
            $0.addTextField(configurationHandler: { (inputValue) in
                inputTextfield = inputValue
                inputTextfield.keyboardType = inputType
                inputTextfield.placeholder = placeHolder
            })
            $0.addAction(UIAlertAction(title: cancelButtonTitle,
                                       style: .cancel,
                                       handler: nil))
            $0.addAction(UIAlertAction(title: saveButtonTitle,
                                       style: .default,
                                       handler: { _ in
                                       handler?(inputTextfield.text ?? "")
            }))
        }
        UIViewController.top()?.present(alert, animated: true)
    }
    
}
