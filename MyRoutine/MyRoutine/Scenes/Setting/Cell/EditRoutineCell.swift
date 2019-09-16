//
//  EditRoutineCell.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/15/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class EditRoutineCell: UITableViewCell, NibReusable {
    
    // MARK: - Outlets
    @IBOutlet private weak var routineNameLabel: UILabel!
    @IBOutlet private weak var routineInfoLabel: UILabel!
    
    // MARK: - SetUp
    func setContentCell(routine: RoutineModel) {
        routineNameLabel.text = routine.nameRoutine
        var routineInfo = ""
        if routine.repeatRoutine.count == Constants.numberDayOnWeek {
            routineInfo = "Hàng ngày"
        } else {
            routineInfo = routine.repeatRoutine.map { $0.shortTitle }
                                               .reduce("", { $0 + " " + $1 })
        }
        routineInfoLabel.text = routineInfo
    }
}
