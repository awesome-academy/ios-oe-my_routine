//
//  RoutineService.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/2/19.
//  Copyright © 2019 huy. All rights reserved.
//

import RealmSwift

class RoutineService {
    
    // MARK: - Singleton
    static let shared = RoutineService()
    
    // MARK: - Supporting function
    func getAllRoutine() -> [RoutineModel] {
        let list = RealmService.shared.load(listOf: RoutineModelRealm.self)
        return list.map({ (obj) in
            return RoutineModel(idRoutine: obj.idRoutine,
                                name: obj.name,
                                dayStart: obj.dayStart,
                                repeatRoutine: obj.repeatRoutine,
                                remind: obj.remind,
                                period: obj.period)
        })
    }
    
    func saveRoutinetoDB(_ routine: RoutineModel, completion: ((RoutineModelRealm?) -> Void)? = nil) {
        do {
            let realm = try Realm()
            try realm.write {
                let obj = RoutineModelRealm()
                obj.idRoutine = String(routine.idRoutine)
                obj.name = routine.name
                obj.dayStart = routine.dayStart
                var temp = [String]()
                temp.append(contentsOf: routine.repeatRoutine.map { String($0) })
                obj.repeatRoutine = temp
                obj.remind = routine.remind
                obj.period = String(obj.period)
                realm.add(obj)
                completion?(obj)
            }
        } catch {
            completion?(nil)
        }
    }
    
}
