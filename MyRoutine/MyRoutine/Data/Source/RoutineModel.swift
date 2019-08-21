//
//  RoutineModel.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/2/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct RoutineModel {
    
    // MARK: - Properties
    var idRoutine: Int
    var nameRoutine: String
    var dayStart: String
    var repeatRoutine: [Bool]
    var targetRoutine: Int
    var remindRoutine: [RemindModel]
    var periodRoutine: Int
    var doneCount: Int
    
    // MARK: - Init
    init(idRoutine: Int, name: String,
         dayStart: String, target: Int,
         repeatRoutine: [Bool], remind: [RemindModel],
         period: Int, doneCount: Int) {
        self.idRoutine = idRoutine
        self.nameRoutine = name
        self.dayStart = dayStart
        self.targetRoutine = target
        self.repeatRoutine = repeatRoutine
        self.remindRoutine = remind
        self.periodRoutine = period
        self.doneCount = doneCount
    }
    
    init (idRoutine: Int, name: String,
          dayStart: String, target: Int,
          repeatRoutine: List<Bool>, remind: List<RemindModel>,
          period: Int, doneCount: Int) {
        self.idRoutine = idRoutine
        self.nameRoutine = name
        self.dayStart = dayStart
        self.targetRoutine = target
        self.repeatRoutine = repeatRoutine.toArray(type: Bool.self)
        self.remindRoutine = remind.toArray(type: RemindModel.self)
        self.periodRoutine = period
        self.doneCount = doneCount
    }
    
    static func defautInit() -> RoutineModel {
        return  RoutineModel(idRoutine: RoutineService.shared.getAllRoutine().count,
                             name: "NewRoutine",
                             dayStart: Date().getStringDate(),
                             target: 1,
                             repeatRoutine: Constants.allWeek,
                             remind: [RemindModel(timeString: "9:00", state: true)],
                             period: 4,
                             doneCount: 0)
    }
    
}
