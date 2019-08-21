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
            obj.repeatRoutine.append(i)
        }
        for i in routine.remindRoutine {
            obj.remindRoutine.append(i)
        }
        obj.period = routine.periodRoutine
        obj.doneCount = routine.doneCount
        return obj
    }
    
    func routineRealmToRoutine(routineRealm: RoutineModelRealm) -> RoutineModel {
        return RoutineModel(idRoutine: routineRealm.idRoutine,
                            name: routineRealm.name,
                            dayStart: routineRealm.dayStart,
                            target: routineRealm.targetRoutine,
                            repeatRoutine: routineRealm.repeatRoutine,
                            remind: routineRealm.remindRoutine,
                            period: routineRealm.period,
                            doneCount: routineRealm.doneCount)
    }
    
}
