//
//  CellSetUp.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/3/19.
//  Copyright © 2019 huy. All rights reserved.
//

class CellSetUp: UITableViewCell {
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblSetting: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    func setUp(iconSetting: UIImage, setting: String, state: String) {
        icon.image = iconSetting
        lblSetting.text = setting
        lblState.text = state
    }
}
