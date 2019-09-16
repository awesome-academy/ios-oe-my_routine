//
//  StasticRoutineFooterCell.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/9/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class StatisticRoutineFooterCell: UITableViewCell, NibLoadable {
    
    // MARK: - Outlets
    @IBOutlet private weak var expandButton: UIButton!
    
    // MARK: - Setup
    func setContentForCell(isExpanded: Bool) {
        expandButton.setTitle(isExpanded ? "Thu gọn" : "Hiển thị tất cả",
                              for: .normal)
    }
    
}
