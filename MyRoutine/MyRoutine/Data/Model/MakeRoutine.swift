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
}

class MakeRoutineRealm: Object {
    @objc dynamic var routineID = ""
    @objc dynamic var doneTimes = 0
}
