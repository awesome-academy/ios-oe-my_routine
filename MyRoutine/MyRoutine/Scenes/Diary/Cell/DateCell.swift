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

    func setDateForCell(date: String, weekDay: String, choose: Bool) {
        dateLabel.text = date
        weekDayLabel.text = weekDay
        roundedview.isHidden = !choose
    }
}
