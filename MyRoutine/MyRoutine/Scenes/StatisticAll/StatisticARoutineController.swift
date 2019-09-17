//
//  StatisticARoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/17/19.
//  Copyright © 2019 huy. All rights reserved.
//

import FSCalendar

final class StatisticARoutineController: UIViewController {

    @IBOutlet weak var dateFromCalendarLabel: UILabel!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var maxConsecutiveDaysLabel: UILabel!
    @IBOutlet weak var weekTargetLabel: UILabel!
    
    var statisticARouine: StatisticARoutineModel?
    var weekTarget: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCalendar()
        setUpViewAndData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadDataCalendar()
    }
    
    private func setUpCalendar() {
        calendarView.do {
            $0.dataSource = self
            $0.today = nil
            dateFromCalendarLabel.text = Date().getMonthAndYearString()
        }
    }
    
    private func setUpViewAndData() {
        maxConsecutiveDaysLabel.text = "\(statisticARouine?.longestConsecutiveFinishDays ?? 0)"
        weekTargetLabel.text = weekTarget
    }
    
    private func reloadDataCalendar() {
        guard let dates = statisticARouine?.finishDays else { return }
        calendarView.do {
            $0.allowsSelection = true
            $0.allowsMultipleSelection = true
            for date in dates {
                $0.select(date)
            }
            $0.allowsSelection = false
        }
    }
}

extension StatisticARoutineController: FSCalendarDataSource {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        dateFromCalendarLabel.text = calendar.currentPage.getMonthAndYearString()
    }
}

extension StatisticARoutineController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.statisticARoutine
}
