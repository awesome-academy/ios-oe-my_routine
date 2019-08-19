//
//  CellSetUp.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/3/19.
//  Copyright © 2019 huy. All rights reserved.
//

class CellSetUp: UITableViewCell, NibReusable {
    
    // MARK: - Outlets
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    // MARK: Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setUp(iconSetting: UIImage, setting: String, state: String) {
        iconImage.image = iconSetting
        settingLabel.text = setting
        stateLabel.text = state
    }
    
}
