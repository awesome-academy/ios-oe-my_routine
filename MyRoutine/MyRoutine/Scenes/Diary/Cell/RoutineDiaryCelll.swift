//
//  RoutineDiaryCelll.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/22/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class RoutineDiaryCelll: UITableViewCell, NibReusable {

    @IBOutlet private weak var progessBar: UIProgressView!
    @IBOutlet private weak var doneTimesLabel: UILabel!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var completeImage: UIImageView!
    @IBOutlet private weak var nameRoutineLabel: UILabel!
    
    func setContentForCell(makeRoutine: MakeRoutine) {
        let doneCount = Int(makeRoutine.completion.doneCount)
        let percentDone = Int(makeRoutine.completion.currentProgess)
        let targetTime = Int(makeRoutine.completion.targetTime)
        nameRoutineLabel.text = makeRoutine.routine.nameRoutine
        doneTimesLabel.text = "\(doneCount) / \(targetTime)"
        percentLabel.text = "\(percentDone) %"
        progessBar.progress = makeRoutine.completion.currentProgess
        completeImage.image = makeRoutine.completion.currentProgess == 1 ? #imageLiteral(resourceName: "approve") : #imageLiteral(resourceName: "notdone")
    }
    
}
