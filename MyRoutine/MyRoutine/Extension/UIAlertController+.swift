//
//  UIAlertController+.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/13/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension UIAlertController {
    
    static func showQuickSystemAlert(title: String? = nil,
                                     message: String? = nil,
                                     cancelButtonTitle: String = "OK",
                                     handler: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: cancelButtonTitle,
                                        style: .cancel,
                                        handler: { _ in
            handler?()
        }))
        UIViewController.top()?.present(alertVC, animated: true)
    }
    
    static func showInputAlert(title: String? = nil, message: String? = nil,
                               cancelButtonTitle: String = "OK",
                               inputType: UIKeyboardType = UIKeyboardType.default,
                               placeHolder: String = "",
                               saveButtonTitle: String,
                               handler: ((String) -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        var inputTextfield = UITextField()
        alert.addTextField { (inputValue) in
            inputTextfield = inputValue
            inputTextfield.keyboardType = inputType
            inputTextfield.placeholder = placeHolder
        }
        alert.addAction(UIAlertAction(title: cancelButtonTitle,
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: saveButtonTitle,
                                      style: .default,
                                      handler: { _ in
            handler?(inputTextfield.text ?? "")
        }))
        UIViewController.top()?.present(alert, animated: true)
    }
    
}
