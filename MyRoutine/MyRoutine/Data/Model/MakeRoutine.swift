//
//  MakeRoutine.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/4/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct MakeRoutine {
    var routine: RoutineModel
    var completion: CompletionModel
    var isComplete: Bool {
        return completion.currentProgess == 1
    }
}

class MakeRoutineRealm: Object {
    @objc dynamic var routineID = ""
    @objc dynamic var doneTimes = 0
}

class MapperMakeRoutine {
    
    // MARK: - Singleton
    static let shared = MapperMakeRoutine()
    
    // MARK: - Method
    func makeRoutineToRealm(_ makeRoutine: MakeRoutine) -> MakeRoutineRealm {
        let result = MakeRoutineRealm().then {
            $0.routineID = makeRoutine.routine.idRoutine
            $0.doneTimes = Int(makeRoutine.completion.doneCount)
        }
        return result
    }
    
    func makeRoutineRealmToMakeRoutine(_ makeRoutineRealm: MakeRoutineRealm) -> MakeRoutine {
        let routine = RoutineDatabase.shared.getRoutineByID(ID: makeRoutineRealm.routineID) ??
            RoutineModel.defautInit()
        let completion = CompletionModel(targetTime: Float(routine.targetRoutine),
                                         doneCount: 0)
        return MakeRoutine(routine: routine, completion: completion)
    }
}
