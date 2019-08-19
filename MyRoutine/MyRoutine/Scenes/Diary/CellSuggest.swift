//
//  CellSuggest.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/3/19.
//  Copyright © 2019 huy. All rights reserved.
//

class CellSuggest: UICollectionViewCell, NibReusable {
    
    // MARK: - Outlets
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var suggestLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp(icon: String, suggest: String) {
        iconLabel.text = icon
        suggestLabel.text = suggest
    }
    
}
