//
//  ChangePasswordCell.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/14/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class ChangePasswordCell: UITableViewCell, NibReusable {
    
    // MARK: - Outlets
    @IBOutlet private weak var changePasswordLabel: UILabel!
    @IBOutlet private weak var imageNext: UIImageView!
    
    // MARK: - Setup
    func disableContent(isDisable: Bool) {
        self.isUserInteractionEnabled = !isDisable
        changePasswordLabel.isEnabled = !isDisable
        imageNext.alpha = isDisable ? 0.3 : 1
    }
}
