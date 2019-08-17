//
//  CellSuggest.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/3/19.
//  Copyright © 2019 huy. All rights reserved.
//

class CellSuggest: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var viewIcon: UIView!
    @IBOutlet weak var lblSuggest: UILabel!
    @IBOutlet weak var lblIcon: UILabel!
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp(icon: String, suggest: String) {
        lblIcon.text = icon
        lblSuggest.text = suggest
    }
    
}
