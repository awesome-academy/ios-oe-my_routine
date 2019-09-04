//
//  PeriodDay.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/30/19.
//  Copyright © 2019 huy. All rights reserved.
//

enum PeriodDay: Int {
    case Morning = 0
    case Midday = 1
    case Afternoon = 2
    case Night = 3
    var value: Int { return rawValue }
    var title: String {
        switch self {
        case .Morning:
            return "Sáng"
        case .Midday:
            return "Trưa"
        case .Afternoon:
            return "Chiều"
        case .Night:
            return "Tối"
        }
    }
}
