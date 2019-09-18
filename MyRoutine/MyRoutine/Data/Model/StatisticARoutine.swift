//
//  StatisticARoutineModel.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct StatisticARoutine {
    
    var routineID: String
    var finishDays: [Date]
    var longestConsecutiveFinishDays: Int {
        return DateService.shared.maximalConsecutiveDate(days: finishDays)
    }
    
    init(dayInfos: [DayInfo], routineID: String) {
        var finishDays = [Date]()
        self.routineID = routineID
        for dayInfo in dayInfos {
            for makeRou in dayInfo.makeRoutines where makeRou.routine.idRoutine == routineID {
                if makeRou.isComplete {
                    finishDays.append(dayInfo.date.getDate(format: DateFormat.fullDateFormat.rawValue))
                }
                break
            }
        }
        self.finishDays = finishDays
    }
}
