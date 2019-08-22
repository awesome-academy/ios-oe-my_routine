//
//  Date+.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/21/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension Date {
    
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
}
