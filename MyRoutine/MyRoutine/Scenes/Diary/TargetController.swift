//
//  TargetController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/5/19.
//  Copyright © 2019 huy. All rights reserved.
//

class TargetController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblRepeat: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblRepeatUnit: UILabel!
    
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
        lblRepeat.text = String(target.number)
        lblRepeatUnit.text = target.type == 1 ? "lần / ngày" : "phút / ngày"
        lblUnit.text = target.type == 1 ? "Theo số lần" : "Theo thời gian"
    }
    
    // MARK: - Actions
    @IBAction func btnSave(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Target"),
                                        object: nil,
                                        userInfo: ["message": target])
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPickerview(_ sender: Any) {
        PickerViewControl.showTextPicker(list: choices, defaultIndex: 0) {[weak self] (reponse) in
            if let res = reponse {
                self?.target.type = res.index + 1
                self?.lblUnit.text = res.stringValue
                self?.lblRepeatUnit.text = res.index == 0 ?  "lần / ngày" : "phút / ngày"
            }
        }
    }
    @IBAction func btninputValue(_ sender: Any) {
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
                self?.target.number = inputText.int ?? 1
                self?.lblRepeat.text = inputText + " "
            } else {
                self?.target.number = 1
                self?.lblRepeat.text = "1 "
            }
        }
    }
}
