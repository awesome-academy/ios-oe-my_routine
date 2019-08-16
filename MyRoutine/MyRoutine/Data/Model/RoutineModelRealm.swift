//
//  RoutineModelRealm.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/2/19.
//  Copyright © 2019 huy. All rights reserved.
//

class RoutineModelRealm: Object {
    
    // MARK: - Properties
    @objc dynamic var idRoutine = 0
    @objc dynamic var name = ""
    @objc dynamic var dayStart = Date()
    @objc dynamic var period = 4
    @objc dynamic var targetRoutine: TargetModel?
    @objc dynamic var repeatRoutine: RepeatModel?
    let remindRoutine = List<RemindModel>()
    @objc dynamic var doneCount = 0
    
}
