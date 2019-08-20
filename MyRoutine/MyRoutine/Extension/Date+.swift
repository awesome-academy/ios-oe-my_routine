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
    
    static func getWeekDay(day: Int) -> String {
        switch day {
        case 0:
            return "Thứ Hai"
        case 1:
            return "Thứ Ba"
        case 2:
            return "Thứ Tư"
        case 3:
            return "Thứ Năm"
        case 4:
            return "Thứ Sáu"
        case 5:
            return "Thứ Bảy"
        case 6:
            return "Chủ Nhật"
        default:
            return ""
        }
    }
    
    static func getWeekDayShort(day: Int) -> String {
        switch day {
        case 0:
            return "Th 2"
        case 1:
            return "Th 3"
        case 2:
            return "Th 4"
        case 3:
            return "Th 5"
        case 4:
            return "Th 6"
        case 5:
            return "Th 7"
        case 6:
            return "CN"
        default:
            return ""
        }
    }
    
}
