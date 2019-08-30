//
//  CellRemind.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/9/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class RemindCell: UITableViewCell, NibReusable {
    
    // MARK: - Outlets
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var switchTime: UISwitch!
    
    // Closure
    var didChangeSwitch: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        didChangeSwitch?(switchTime.isOn)
    }
    
    func setRemindContent(timeRemind: String, switchOn: Bool) {
        lblTime.text = timeRemind
        switchTime.setOn(switchOn, animated: true)
    }
}
