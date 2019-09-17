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
    var noteRoutine: String
    
    // MARK: - Init
    static func defautInit() -> RoutineModel {
        return RoutineModel(idRoutine: Date().getStrDateFormat(format: "yyyyMMddHHmmss"),
                            nameRoutine: "NewRoutine",
                            dayStart: Date().getFullDateString(),
                            repeatRoutine: Constants.allWeek,
                            targetRoutine: 1,
                            remindRoutine: [RemindModel(timeString: "09:00", state: true)],
                            periodRoutine: 4,
                            doneCount: 0,
                            noteRoutine: "")
    }
}

class MapperRoutine {
    
    // MARK: - Singletion
    static let shared = MapperRoutine()
    
    // MARK: - Method
    func routineToRoutineRealm(routine: RoutineModel) -> RoutineModelRealm {
        let obj = RoutineModelRealm()
        obj.idRoutine = routine.idRoutine
        obj.name = routine.nameRoutine
        obj.dayStart = routine.dayStart
        obj.targetRoutine = routine.targetRoutine
        for i in routine.repeatRoutine {
            obj.repeatRoutine.append(i.value)
        }
        for i in routine.remindRoutine {
            obj.remindRoutine.append(i)
        }
        obj.doneCount = routine.doneCount
        obj.note = routine.noteRoutine
        return obj
    }
    
    func routineRealmToRoutine(routineRealm: RoutineModelRealm) -> RoutineModel {
        return RoutineModel(idRoutine: routineRealm.idRoutine,
                            nameRoutine: routineRealm.name,
                            dayStart: routineRealm.dayStart,
                            repeatRoutine: routineRealm.repeatRoutine.map {
                                return DayOfWeek(rawValue: $0) ?? DayOfWeek.Monday
                            },
                            targetRoutine: routineRealm.targetRoutine,
                            remindRoutine: routineRealm.remindRoutine.toArray(type: RemindModel.self),
                            periodRoutine: routineRealm.period,
                            doneCount: routineRealm.doneCount,
                            noteRoutine: routineRealm.note)
    }
}
