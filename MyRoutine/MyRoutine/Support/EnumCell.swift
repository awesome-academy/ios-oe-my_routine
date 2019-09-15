//
//  Enum.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/30/19.
//  Copyright © 2019 huy. All rights reserved.
//

enum CellStateRoutineTableView: Int {
    case repeatCell = 0
    case dayStartCell = 1
    case targetCell = 2
    case remindCell = 3
    case periodCell = 4
}

enum CellRemindTableView: Int {
    case remind = 0
    case addRemind = 1
}

enum CellSettingTableView: Int {
    case manageRoutine = 0
    case passwordMode = 1
}

enum CellSetUpPasswordTableView: Int {
    case passWordMode = 0
    case touchIDMode = 1
    case changePassword = 2
}
