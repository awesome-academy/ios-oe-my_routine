//
//  SetUpPasswordCell.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/14/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class SetUpPasswordCell: UITableViewCell, NibReusable {
    
    // MARK: - Outlets
    @IBOutlet private weak var passwordSwitch: UISwitch!
    @IBOutlet private weak var typePasswordLabel: UILabel!
    
    // MARK: - Closure
    var didChangeSwitch: ((Bool) -> Void)?
    
    // MARK: - Setup
    func setContentForCell(passwordMode: String, state: Bool, isDisable: Bool) {
        self.isUserInteractionEnabled = !isDisable
        typePasswordLabel.text = passwordMode
        typePasswordLabel.isEnabled = !isDisable
        passwordSwitch.isEnabled = !isDisable
        passwordSwitch.isOn = isDisable ? false : state
    }
    
    @IBAction func handleChangeSwitch(_ sender: Any) {
        didChangeSwitch?(passwordSwitch.isOn)
    }
}
