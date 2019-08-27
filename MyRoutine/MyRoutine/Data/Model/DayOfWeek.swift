//
//  DayOfWeek.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/21/19.
//  Copyright © 2019 huy. All rights reserved.
//

enum DayOfWeek: Int {
    case Sunday = 1
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
    var value: Int { return rawValue }
    var title: String {
        switch self {
        case .Monday:
            return "Thứ Hai"
        case .Tuesday:
            return "Thứ Ba"
        case .Wednesday:
            return "Thứ Tư"
        case .Thursday:
            return "Thứ Năm"
        case .Friday:
            return "Thứ Sáu"
        case .Saturday:
            return "Thứ Bảy"
        case .Sunday:
            return "Chủ Nhật"
        }
    }
    var shortTitle: String {
        switch self {
        case .Monday:
            return "Th 2"
        case .Tuesday:
            return "Th 3"
        case .Wednesday:
            return "Th 4"
        case .Thursday:
            return "Th 5"
        case .Friday:
            return "Th 6"
        case .Saturday:
            return "Th 7"
        case .Sunday:
            return "CN"
        }
    }
}
