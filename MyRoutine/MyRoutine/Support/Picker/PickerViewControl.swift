//
//  PickerViewControl.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/8/19.
//  Copyright © 2019 huy. All rights reserved.
//

class PickerViewControl {
    
    // MARK: Method
    static func showDatePicker(type: UIDatePicker.Mode,
                               title: String,
                               completion: ((Date?) -> Void)?) {
        let pickerView = DatePicker.loadFromNib()
        pickerView.setupPickerView(type, title: title)
        pickerView.didSelectText = { response in
            completion?(response)
        }
        pickerView.showPickerView()
    }
    
}
