//
//  RoutineModelRealm.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/2/19.
//  Copyright © 2019 huy. All rights reserved.
//

class RoutineModelRealm: Object {
    
    // MARK: - Properties
    @objc dynamic var idRoutine = ""
    @objc dynamic var name = ""
    @objc dynamic var dayStart = ""
    @objc dynamic var period = 4
    @objc dynamic var targetRoutine = 1
    let repeatRoutine = List<Int>()
    let remindRoutine = List<RemindModel>()
    @objc dynamic var doneCount = 0
    @objc dynamic var note = ""
    
    override static func primaryKey() -> String? {
        return "idRoutine"
    }
}
