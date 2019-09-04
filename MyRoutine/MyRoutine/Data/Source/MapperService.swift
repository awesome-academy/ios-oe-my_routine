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
        var checkSelect = Array.init(repeating: false, count: 7)
        for i in days {
            checkSelect[i.value-1] = true
        }
        return checkSelect
    }
    
    func boolCheckToDaysOfWeek(check: [Bool]) -> [DayOfWeek] {
        var daysOfWeek = [DayOfWeek]()
        for i in 1 ... check.count where check[i-1] {
            daysOfWeek.append(DayOfWeek(rawValue: i) ?? DayOfWeek.Monday)
        }
        return daysOfWeek
    }
    
    func makeRoutineToRealm(_ makeRoutine: MakeRoutine) -> MakeRoutineRealm {
        let result = MakeRoutineRealm().then {
            $0.routineID = makeRoutine.routine.idRoutine
            $0.doneTimes = Int(makeRoutine.completion.doneCount)
        }
        return result
    }
    
    func makeRoutineRealmToMakeRoutine(_ makeRoutineRealm: MakeRoutineRealm) -> MakeRoutine {
        let routine = RoutineService.shared.getRoutineByID(ID: makeRoutineRealm.routineID) ??
                      RoutineModel.defautInit()
        let completion = CompletionModel(targetTime: Float(routine.targetRoutine),
                                         doneCount: 0)
        return MakeRoutine(routine: routine, completion: completion)
    }
    
    func dayInfoToRealm(_ dayInfo: DayInfo) -> DayInfoRealm {
        let result = DayInfoRealm().then {
            $0.date = dayInfo.date
            for i in dayInfo.makeRoutines {
                $0.makeRoutines.append(makeRoutineToRealm(i))
            }
        }
        return result
    }
    
    func dayInfoRealmToDayInfo(_ dayInfoRealm: DayInfoRealm) -> DayInfo {
        var makeRoutines = [MakeRoutine]()
        for i in dayInfoRealm.makeRoutines {
            makeRoutines.append(makeRoutineRealmToMakeRoutine(i))
        }
        return DayInfo(date: dayInfoRealm.date,
                       makeRoutines: makeRoutines)
    }
}
