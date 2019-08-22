//
//  RoutineModel.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/2/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct RoutineModel {
    
    // MARK: - Properties
    var idRoutine: String
    var nameRoutine: String
    var dayStart: String
    var repeatRoutine: [DayOfWeek]
    var targetRoutine: Int
    var remindRoutine: [RemindModel]
    var periodRoutine: Int
    var doneCount: Int
    
    // MARK: - Init
    static func defautInit() -> RoutineModel {
        return RoutineModel(idRoutine: Date().getStrDateFormat(format: "yyyyMMddHHmmss"),
                            nameRoutine: "NewRoutine",
                            dayStart: Date().getStringDate(),
                            repeatRoutine: Constants.allWeek,
                            targetRoutine: 1,
                            remindRoutine: [RemindModel(timeString: "09:00", state: true)],
                            periodRoutine: 4,
                            doneCount: 0)
    }
    
}
