//
//  CellSetUp.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/3/19.
//  Copyright © 2019 huy. All rights reserved.
//

class CellSetUp: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblSetting: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    // MARK: Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setUp(iconSetting: UIImage, setting: String, state: String) {
        icon.image = iconSetting
        lblSetting.text = setting
        lblState.text = state
    }
    
}
