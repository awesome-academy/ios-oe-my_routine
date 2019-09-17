//
//  WeekInfo.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/17/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct WeekInfo {
    var daysInWeek: [Date]
    var makeRoutines: [MakeRoutine]
    var totalTargetTimes: Float {
        return makeRoutines.map { $0.completion.targetTime }.reduce(0, +)
    }
    var totalDoneTimes: Float {
        return makeRoutines.map { $0.completion.doneCount }.reduce(0, +)
    }
    var totalCurrentProgess: Float {
        return totalDoneTimes / totalTargetTimes
    }
}

