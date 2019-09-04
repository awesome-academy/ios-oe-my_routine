//
//  DayInfo.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/4/19.
//  Copyright © 2019 huy. All rights reserved.
//

typealias CompletionRoutine = (routineNumber: Int, routineDone: Int)

struct DayInfo {
    var date: String
    var makeRoutines: [MakeRoutine]
    var completion: CompletionRoutine {
        return (makeRoutines.count,
                makeRoutines.filter { $0.completion.percentDone == 1 }.count)
    }
}

class DayInfoRealm: Object {
    @objc dynamic var date = ""
    let makeRoutines = List<MakeRoutineRealm>()
}

class MapperDayInfo {
    
    // MARK: - Singleton
    static let shared = MapperDayInfo()
    
    // MARK: - Method
    func dayInfoToRealm(_ dayInfo: DayInfo) -> DayInfoRealm {
        let result = DayInfoRealm().then {
            $0.date = dayInfo.date
            for i in dayInfo.makeRoutines {
                $0.makeRoutines.append(MapperMakeRoutine.shared.makeRoutineToRealm(i))
            }
        }
        return result
    }
    
    func dayInfoRealmToDayInfo(_ dayInfoRealm: DayInfoRealm) -> DayInfo {
        var makeRoutines = [MakeRoutine]()
        for i in dayInfoRealm.makeRoutines {
            makeRoutines.append(MapperMakeRoutine.shared.makeRoutineRealmToMakeRoutine(i))
        }
        return DayInfo(date: dayInfoRealm.date,
                       makeRoutines: makeRoutines)
    }
}
