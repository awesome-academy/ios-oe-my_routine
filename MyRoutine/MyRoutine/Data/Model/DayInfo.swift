//
//  DayInfo.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/4/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct DayInfo {
    var date: String
    var makeRoutines: [MakeRoutine]
}

class DayInfoRealm: Object {
    @objc dynamic var date = ""
    let makeRoutines = List<MakeRoutineRealm>()
}
