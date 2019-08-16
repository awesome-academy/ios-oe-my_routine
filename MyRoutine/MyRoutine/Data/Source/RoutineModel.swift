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
    var dayStart: Date
    var repeatRoutine: RepeatModel
    var targetRoutine: TargetModel
    var remindRoutine: [RemindModel]
    var periodRoutine: Int
    var doneCount: Int
    
    // MARK: - Init
    init(idRoutine: Int, name: String,
         dayStart: Date, target: TargetModel,
         repeatRoutine: RepeatModel, remind: [RemindModel],
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
          dayStart: Date, target: TargetModel,
          repeatRoutine: RepeatModel, remind: List<RemindModel>,
          period: Int, doneCount: Int) {
        self.idRoutine = idRoutine
        self.nameRoutine = name
        self.dayStart = dayStart
        self.targetRoutine = target
        self.repeatRoutine = repeatRoutine
        self.remindRoutine = remind.toArray(type: RemindModel.self)
        self.periodRoutine = period
        self.doneCount = doneCount
    }
    
}
