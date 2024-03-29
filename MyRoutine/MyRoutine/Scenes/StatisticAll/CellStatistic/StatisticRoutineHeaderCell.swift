//
//  StasticRoutineHeaderCell.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/9/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class StatisticRoutineHeaderCell: UITableViewCell, NibLoadable {
    
    // MARK: - Outlets
    @IBOutlet private weak var dateRangeLabel: UILabel!
    @IBOutlet private weak var completionProgessBar: UIProgressView!
    
    // MARK: - Setup
    func setContentForCell(days: [Date], completion: Float) {
        let firstDate = days.first?.getShortVNDateString() ?? ""
        let lastDate = days.last?.getShortVNDateString() ?? ""
        dateRangeLabel.text = "( \(firstDate) - \(lastDate) )"
        completionProgessBar.setProgress(completion,
                                         animated: true)
    }
}
