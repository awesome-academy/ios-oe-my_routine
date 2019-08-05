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
    static let intance = RoutineService()
    
    // MARK: - Supporting function
    func getAllRoutine() -> [RoutineModel] {
        let list = RealmService.instance.load(listOf: RoutineModelRealm.self)
        return list.map({ (obj) in
            return RoutineModel(idRoutine: obj.idRoutine, name: obj.name,
                                dayStart: obj.dayStart, repeatRoutine: obj.repeatRoutine,
                                remind: obj.remind, period: obj.period)
        })
    }
    
    func saveRoutinetoDB(rou: RoutineModel) {
        do {
            let realm = try Realm()
            try realm.write {
                let obj = RoutineModelRealm()
                obj.idRoutine = String(rou.idRoutine)
                obj.name = rou.name
                obj.dayStart = rou.dayStart
                var temp = [String]()
                temp.append(contentsOf: rou.repeatRoutine.map { String($0) })
                obj.repeatRoutine = temp
                obj.remind = rou.remind
                obj.period = String(obj.period)
                realm.add(obj)
            }
        } catch let err {
            print(err)
        }
    }
    
}
