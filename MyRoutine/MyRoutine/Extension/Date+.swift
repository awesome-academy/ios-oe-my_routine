//
//  UIDatePicker+.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/8/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension Date {
    func stringBy(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    func getStringDate() -> String {
        return self.stringBy(format: "dd/MM/YYYY")
    }
    func getStringHour() -> String {
        return self.stringBy(format: "HH:mm")
    }
}
