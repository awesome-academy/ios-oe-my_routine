//
//  MapperService.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/21/19.
//  Copyright © 2019 huy. All rights reserved.
//

class MapperService {
    
    // Singleton
    static let shared = MapperService()
    
    // Mapper Funtion
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
                            doneCount: routineRealm.doneCount)
    }
    
    func convertAnyToObject<T, E>(any: T, typeOpject: E.Type) -> E? {
        return any as? E
    }
    
    func daysOfWeekToBoolCheck(days: [DayOfWeek]) -> [Bool] {
        var checkSelect = [false, false, false, false, false, false, false]
        for i in days {
            checkSelect[i.value] = true
        }
        return checkSelect
    }
    
    func boolCheckToDaysOfWeek(check: [Bool]) -> [DayOfWeek] {
        var daysOfWeek = [DayOfWeek]()
        for i in 0 ..< check.count where check[i] {
            daysOfWeek.append(DayOfWeek(rawValue: i) ?? DayOfWeek.Monday)
        }
        return daysOfWeek
    }
    
}
