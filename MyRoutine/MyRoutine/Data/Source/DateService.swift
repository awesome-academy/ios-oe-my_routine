//
//  DateService.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

class DateService {
    
    // MARK: - Singleton
    static let shared = DateService()
    
    // MARK: - Function
    /// This function returns array of Date include tomorrow, today,
    ///                                 and (number-2) days before today
    /// Usage:
    ///
    ///     println(Date.getArrayOfDate(number: 3) // [2019-08-11 01:30:40 +0000,
    ///                                                 2019-08-12 01:30:40 +0000,
    ///                                                 2019-08-13 01:30:40 +0000]
    ///.    -> [yesterday, today, tomorrow]
    ///
    /// - Parameter number: The number of day in the array.
    ///
    func getArrayOfDate(numberOfDate: Int) -> [Date] {
        var result = [Date]()
        let today = Date().getFullDateString().getDate(format: Constants.dateFullFormat)
        for i in 0 ..< numberOfDate {
            result.append(today.addingTimeInterval(TimeInterval((i - numberOfDate + 2)*86400)))
        }
        return result
    }
}
