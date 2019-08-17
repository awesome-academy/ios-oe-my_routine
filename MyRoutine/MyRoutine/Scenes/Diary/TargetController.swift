//
//  TargetController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/17/19.
//  Copyright © 2019 huy. All rights reserved.
//

import UIKit

class TargetController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    // MARK: - Variables
    let choices = ["Theo số lần", "Theo thời gian"]
    var target = TargetModel(type: 1, number: 1)
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Setup
    func setUp() {
        lblNumber.text = String(target.number)
        lblUnit.text = target.type == 1 ? "lần / ngày" : "phút / ngày"
        lblType.text = target.type == 1 ? "Theo số lần" : "Theo thời gian"
    }
    
    @IBAction func btnSave(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Target"),
                                        object: nil,
                                        userInfo: ["message": target])
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func chooseType(_ sender: Any) {
        PickerViewControl.showTextPicker(list: choices,
                                         defaultIndex: 0) {[weak self] reponse in
            if let res = reponse {
                self?.target.type = res.index + 1
                self?.lblType.text = res.stringValue
                self?.lblUnit.text = res.index == 0 ?  "lần / ngày" : "phút / ngày"
            }
        }
    }
    
    @IBAction func inputValue(_ sender: Any) {
        if target.type == 1 {
            showAlert(title: "Nhập số lần",
                      message: "Số lần bạn thực hiện trong ngày: ")
        } else {
            showAlert(title: "Nhập số phút",
                      message: "Số phút bạn thực hiện trong ngày: ")
        }
    }
    
    func showAlert(title: String, message: String) {
        UIAlertController.showInputAlert(title: title,
                                         message: message,
                                         cancelButtonTitle: "Huỷ",
                                         inputType: .numberPad,
                                         placeHolder: "Nhập giá trị",
                                         saveButtonTitle: "Lưu") {[weak self] (inputText) in
            if inputText != "" {
                self?.target.number = inputText.int
                self?.lblNumber.text = inputText + " "
            } else {
                self?.target.number = 1
                self?.lblNumber.text = "1 "
            }
        }
    }
    
}
