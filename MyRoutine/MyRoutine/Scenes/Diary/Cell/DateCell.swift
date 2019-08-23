//
//  CellDate.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/18/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class DateCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var roundedview: RoundedView!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedview.borderWidth = 2
    }

    func setUp(date: String, weekDay: String, choose: Bool) {
        dateLabel.text = date
        weekDayLabel.text = weekDay
        weekDayLabel.textColor = choose ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dateLabel.textColor = choose ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        roundedview.isHidden = !choose
    }
}
