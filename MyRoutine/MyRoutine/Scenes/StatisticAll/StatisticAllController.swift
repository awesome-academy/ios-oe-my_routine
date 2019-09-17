//
//  StatisticAllController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/1/19.
//  Copyright © 2019 huy. All rights reserved.
//

import MBCircularProgressBar

final class StatisticAllController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var numberRoutineTodayLabel: UILabel!
    @IBOutlet private weak var totalNumberOfNotDoneRouLabel: UILabel!
    @IBOutlet private weak var totalNumberOfCompleteRoutineLabel: UILabel!
    @IBOutlet private weak var totalNumberOfRoutinesLabel: UILabel!
    @IBOutlet private weak var completionProgessBar: MBCircularProgressBarView!
    @IBOutlet private weak var hiddenView: UIView!
    @IBOutlet private weak var weekInfoTableView: UITableView!
    @IBOutlet private weak var heightOfScrollView: NSLayoutConstraint!
    @IBOutlet private weak var heightOfTableView: NSLayoutConstraint!
 
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
