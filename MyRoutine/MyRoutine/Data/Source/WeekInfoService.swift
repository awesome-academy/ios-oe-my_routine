//
//  WeekInfoService.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/17/19.
//  Copyright © 2019 huy. All rights reserved.
//

class WeekInfoService {
    
    // MARK: - Singleton
    static let shared = WeekInfoService()
    
    // MARK: - Support Method
    func getWeekInfo(daysOnWeek: [Date]) -> WeekInfo {
        let routineOnWeek = RoutineDatabase.shared.getRoutineForWeek(daysOnWeek: daysOnWeek)
        var makeRouOnWeek = [MakeRoutine]()
        for rou in routineOnWeek {
            let targetRouOnWeek = rou.targetRoutine * rou.repeatRoutine.count
            let completion = CompletionModel(targetTime: Float(targetRouOnWeek),
                                             doneCount: 0)
            let makeRouOnDay = MakeRoutine(routine: rou,
                                           completion: completion)
            makeRouOnWeek.append(makeRouOnDay)
        }
        for dayInfo in DayInfoDatabase.shared.getAllDayInfoForWeek(daysOnWeek: daysOnWeek) {
            for makeRouOnDay in dayInfo.makeRoutines {
                for index in 0 ..< makeRouOnWeek.count
                    where makeRouOnDay.routine.idRoutine ==  makeRouOnWeek[index].routine.idRoutine {
                        makeRouOnWeek[index].completion.doneCount += makeRouOnDay.completion.doneCount
                }
            }
        }
        return WeekInfo(daysInWeek: daysOnWeek,
                        makeRoutines: makeRouOnWeek)
    }
}
