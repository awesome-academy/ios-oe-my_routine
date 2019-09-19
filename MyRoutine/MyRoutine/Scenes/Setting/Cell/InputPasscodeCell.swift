//
//  InputCell.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/18/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class InputPasscodeCell: UICollectionViewCell, NibReusable {

    @IBOutlet private var imageInput: UIImageView!
    
    func setUp(inputed: Bool) {
        imageInput.image = inputed ? #imageLiteral(resourceName: "fillPassword") :  #imageLiteral(resourceName: "notInput")
    }
}
