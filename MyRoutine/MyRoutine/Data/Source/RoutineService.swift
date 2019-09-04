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
            MapperService.shared.routineRealmToRoutine(routineRealm: obj)
        })
    }
    
    func getRoutineByID(ID: String) -> RoutineModel? {
        let list = RealmService.shared.load(listOf: RoutineModelRealm.self,
                                            filter: "idRoutine == '\(ID)'")
        if !list.isEmpty {
            return MapperService.shared.routineRealmToRoutine(routineRealm: list[0])
        }
        return nil
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
                let obj = MapperService.shared.routineToRoutineRealm(routine: routine)
                realm.add(obj)
                completion?(obj)
            }
        } catch {
            completion?(nil)
        }
    }
    
}
