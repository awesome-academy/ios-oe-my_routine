//
//  RealmService.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/2/19.
//  Copyright © 2019 huy. All rights reserved.
//

class RealmService {
    
    // MARK: - Singleton
    static var shared = RealmService()
    
    // MARK: - Supporting function
    func load<T: Object>(listOf: T.Type, filter: String? = nil) -> [T] {
        do {
            var objects = try Realm().objects(T.self)
            if let filter = filter {
                objects = objects.filter(filter)
            }
            var list = [T]()
            for obj in objects {
                list.append(obj)
            }
            return list
        } catch { }
        return []
    }
    
}
