//
//  StatisticRoutineCell.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/9/19.
//  Copyright © 2019 huy. All rights reserved.
//
import MBCircularProgressBar

final class StatisticRoutineCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var completionLabel: UILabel!
    @IBOutlet private weak var routineNameLabel: UILabel!
    @IBOutlet private weak var completionProgessBar: MBCircularProgressBarView!
    
    func setContentForCell(makeRoutine: MakeRoutine) {
        completionLabel.text = "\(Int(makeRoutine.completion.doneCount)) / \(Int(makeRoutine.completion.targetTime))"
        routineNameLabel.text = makeRoutine.routine.nameRoutine
        completionProgessBar.value = CGFloat(makeRoutine.completion.currentProgess * 100)
    }
}
