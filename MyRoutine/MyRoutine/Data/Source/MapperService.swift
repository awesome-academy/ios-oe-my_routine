//
//  MapperService.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/21/19.
//  Copyright © 2019 huy. All rights reserved.
//

class MapperService {
    
    // MARK: - Singleton
    static let shared = MapperService()
    
    // MARK: - Mapper Funtion
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
}
