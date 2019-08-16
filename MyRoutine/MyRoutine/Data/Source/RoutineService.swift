//
//  RoutineService.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/2/19.
//  Copyright © 2019 huy. All rights reserved.
//

class RoutineService {
    
    // MARK: - Singleton
    static let shared = RoutineService()
    
    // MARK: - Supporting function
    func getAllRoutine() -> [RoutineModel] {
        let list = RealmService.shared.load(listOf: RoutineModelRealm.self)
        return list.map({ (obj) in
            return RoutineModel(idRoutine: obj.idRoutine, name: obj.name,
                                dayStart: obj.dayStart, target: obj.targetRoutine!,
                                repeatRoutine: obj.repeatRoutine!, remind: obj.remindRoutine,
                                period: obj.period, doneCount: obj.doneCount)
        })
    }
    func removeAllRoutine() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(RoutineModelRealm.self))
            }
        } catch { }
    }
    func saveRoutinetoDB(_ routine: RoutineModel, completion: ((RoutineModelRealm?) -> Void)? = nil) {
        do {
            let realm = try Realm()
            try realm.write {
                let obj = RoutineModelRealm()
                obj.idRoutine = routine.idRoutine
                obj.name = routine.nameRoutine
                obj.dayStart = routine.dayStart
                obj.targetRoutine = routine.targetRoutine
                obj.repeatRoutine = routine.repeatRoutine
                for i in routine.remindRoutine {
                    obj.remindRoutine.append(i)
                }
                obj.doneCount = routine.doneCount
                realm.add(obj)
                completion?(obj)
            }
        } catch {
            completion?(nil)
        }
    }
    
}
