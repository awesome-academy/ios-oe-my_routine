//
//  PickerViewControl.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/8/19.
//  Copyright © 2019 huy. All rights reserved.
//

class PickerViewControl {
    
    // MARK: Method
    static func showTextPicker(list: [String],
                               defaultIndex: Int = 0,
                               completion: ((TextPickerResponse?) -> Void)?) {
        guard let pickerView = TextPicker.fromNib() as? TextPicker else {
            return
        }
        pickerView.configData(list)
        pickerView.didSelectText = { response in
             completion?(response)
        }
        pickerView.showPickerView()
    }
    static func showDatePicker(type: UIDatePicker.Mode, title: String,
                               completion: ((Date?) -> Void)?) {
        guard let pickerView = DatePicker.fromNib() as? DatePicker else {
            return
        }
        pickerView.setupPickerView(type, title: title)
        pickerView.didSelectText = { response in
            completion?(response)
        }
        pickerView.showPickerView()
    }
    
}
