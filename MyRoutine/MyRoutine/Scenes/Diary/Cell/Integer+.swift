//
//  Integer+.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/3/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension Int {
    var convertToDay: String {
        switch self {
        case 1:
            return "Th 2"
        case 2:
            return "Th 3"
        case 3:
            return "Th 4"
        case 4:
            return "Th 5"
        case 5:
            return "Th 6"
        case 6:
            return "Th 7"
        case 7:
            return "CN"
        default:
            return ""
        }
    }
}
