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
        return self.getStrDateFormat(format: "dd/MM/YYYY")
    }
    
    func getStringHour() -> String {
        return self.getStrDateFormat(format: "HH:mm")
    }
    
    func add(day: Int? = nil, month: Int? = nil, year: Int? = nil,
             hour: Int? = nil, minute: Int? = nil, second: Int? = nil,
             calendar: Calendar = Date.currentCalendar) -> Date? {
        var dateComponent = DateComponents()
        if let year = year { dateComponent.year = year }
        if let month = month { dateComponent.month = month }
        if let day = day { dateComponent.day = day }
        if let hour = hour { dateComponent.hour = hour }
        if let minute = minute { dateComponent.minute = minute }
        if let second = second { dateComponent.second = second }
        return calendar.date(byAdding: dateComponent, to: self)
    }
    
    /// This function returns array of Date include tomorrow, today,
    ///                                 and (number-2) days before today
    /// Usage:
    ///
    ///     println(Date.retunArryOfDate(number: 3) // [2019-08-11 01:30:40 +0000,
    ///                                                 2019-08-12 01:30:40 +0000,
    ///                                                 2019-08-13 01:30:40 +0000]
    ///.    -> [yesterday, today, tomorrow]
    ///
    /// - Parameter number: The number of day in the array.
    ///
    static func returnArrayOfDate(number: Int) -> [Date] {
        var arrayOfDate = [Date]()
        for i in 0..<number {
            arrayOfDate.append(Date().add(day: i - 12) ?? Date())
        }
        return arrayOfDate
    }
    
}
