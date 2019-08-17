//
//  CellRemind.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/9/19.
//  Copyright © 2019 huy. All rights reserved.
//

import UIKit

class CellRemind: UITableViewCell {
    var didChangeSwitch: ((Bool) -> Void)?
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var switchTime: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func switchChanged(_ sender: Any) {
        didChangeSwitch?(switchTime.isOn)
    }
    func setUp(timeRemind: String, switchOn: Bool) {
        lblTime.text = timeRemind
        switchTime.setOn(switchOn, animated: true)
    }
}
