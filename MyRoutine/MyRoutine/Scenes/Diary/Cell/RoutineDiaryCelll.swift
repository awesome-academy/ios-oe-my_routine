//
//  RoutineDiaryCelll.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/22/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class RoutineDiaryCelll: UITableViewCell, NibReusable {

    @IBOutlet weak var nameRoutineLabel: UILabel!
    
    func setContentForCell(routine: RoutineModel) {
        nameRoutineLabel.text = routine.nameRoutine
    }
    
}
