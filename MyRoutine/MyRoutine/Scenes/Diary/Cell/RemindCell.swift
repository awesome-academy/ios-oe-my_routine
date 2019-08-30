//
//  CellRemind.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/9/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class RemindCell: UITableViewCell, NibReusable {
    
    // MARK: - Outlets
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var stateSwitch: UISwitch!
    
    // Closure
    var didChangeSwitch: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        didChangeSwitch?(stateSwitch.isOn)
    }
    
    func setRemindContent(timeRemind: String, switchOn: Bool) {
        timeLabel.text = timeRemind
        stateSwitch.setOn(switchOn, animated: true)
    }
}
