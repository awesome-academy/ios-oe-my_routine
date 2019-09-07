//
//  DayInfoService.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/4/19.
//  Copyright © 2019 huy. All rights reserved.
//

class DayInfoDatabase {
    
    // MARK: - Singleton
    static let shared = DayInfoDatabase()
    
    // MARK: - Method
    func getAllDayInfo() -> [DayInfo] {
        let list = RealmService.shared.load(listOf: DayInfoRealm.self)
        return list.map {
            return MapperDayInfo.shared.dayInfoRealmToDayInfo($0)
        }
    }
    
    func getADayInfo(dateStr: String) -> DayInfo? {
        let list = RealmService.shared.load(listOf: DayInfoRealm.self,
                                            filter: "date = '\(dateStr)'")
        if !list.isEmpty {
            return MapperDayInfo.shared.dayInfoRealmToDayInfo(list[0])
        }
        return nil
    }
    
    func saveDayInfoToDB(dayInfo: DayInfo, completion: ((DayInfoRealm?) -> Void)? = nil) {
        do {
            let realm = try Realm()
            try realm.write {
                let obj = MapperDayInfo.shared.dayInfoToRealm(dayInfo)
                realm.add(obj)
                completion?(obj)
            }
        } catch {
            completion?(nil)
        }
    }
    
    func removeAllDayInfo() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(DayInfoRealm.self))
            }
        } catch { }
    }
    
    func updateDayInfo(dateStr: String, updateDayInfo: DayInfo,
                       completion: ((DayInfo?) -> Void)? = nil) {
        do {
            let realm = try Realm()
            try realm.write {
                let update = MapperDayInfo.shared.dayInfoToRealm(updateDayInfo)
                realm.add(update, update: true)
                completion?(updateDayInfo)
            }
        } catch {
            completion?(nil)
        }
    }
}
