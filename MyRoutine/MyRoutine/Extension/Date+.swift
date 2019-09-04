//
//  Date+.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/21/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension Date {
    
    static let currentCalendar = Calendar(identifier: .gregorian)
    var weekday: Int {
        return Date.currentCalendar.component(.weekday, from: self)
    }
    
    func getStrDateFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getStringDate() -> String {
        return getStrDateFormat(format: "dd/MM/YYYY")
    }
    
    func getStringHour() -> String {
        return getStrDateFormat(format: "HH:mm")
    }
    
    func getFullDateString() -> String {
        return getStrDateFormat(format: Constants.dateFormat) + " -000"
    }
    
    func getShortVNDateString() -> String {
        let day = Date.currentCalendar.component(.day, from: self)
        let month = Date.currentCalendar.component(.month, from: self)
        return "\(day) tháng \(month)"
    }
}
