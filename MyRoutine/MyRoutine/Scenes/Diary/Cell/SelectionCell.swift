//
//  CellOption.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/3/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class SelectionCell: UITableViewCell, NibReusable {
    
    // MARK: - Outlets
    @IBOutlet weak var imageCheck: UIImageView!
    @IBOutlet weak var lblOption: UILabel!
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func setOption(option: String, choose: Bool) {
        lblOption.text = option
        imageCheck.isHidden = !choose
    }
}
