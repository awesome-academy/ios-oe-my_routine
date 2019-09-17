//
//  StatisticAllController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/1/19.
//  Copyright © 2019 huy. All rights reserved.
//

import MBCircularProgressBar

final class StatisticAllController: UIViewController {
    
    // MARK: - Constants
    struct Constants {
        static let heightOfRow: CGFloat = 60
        static let heightOfHeader: CGFloat = 50
        static let heightOfFooter: CGFloat = 50
        static let shortenNumberOfRow = 2
        static var defaultHeightOfTableview: CGFloat {
            return CGFloat(shortenNumberOfRow) * heightOfRow + heightOfHeader + heightOfFooter
        }
    }

    // MARK: - Outlets
    @IBOutlet private weak var numberRoutineTodayLabel: UILabel!
    @IBOutlet private weak var totalNumberOfNotDoneRouLabel: UILabel!
    @IBOutlet private weak var totalNumberOfCompleteRoutineLabel: UILabel!
    @IBOutlet private weak var totalNumberOfRoutinesLabel: UILabel!
    @IBOutlet private weak var completionProgessBar: MBCircularProgressBarView!
    @IBOutlet private weak var hiddenView: UIView!
    @IBOutlet private weak var weekInfoTableView: UITableView!
    @IBOutlet private weak var heightOfScrollView: NSLayoutConstraint!
    @IBOutlet private weak var heightOfTableView: NSLayoutConstraint!
    
    // MARK: - Variables
    private var numberOfRow = 0
    private var isExpanded = false
    private var weekInfo: WeekInfo?
    private var daysInWeek = DateService.shared.allDaysInWeek(dayInWeek: Date())
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshView()
    }
    
    // MARK: - Support Method
    private func setUpTableView() {
        weekInfoTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: StatisticRoutineCell.self)
        }
    }
    
    private func refreshView() {
        weekInfo = WeekInfoService.shared.getWeekInfo(daysOnWeek: daysInWeek)
        setDefaultTableView()
        setUpView()
    }
    
    private func setDefaultTableView() {
        // If week Info is empty, hiddenView appear
        guard let weekInfo = weekInfo else { return }
        isExpanded = false
        hiddenView.isHidden = true
        if weekInfo.makeRoutines.count < Constants.shortenNumberOfRow {
            numberOfRow = weekInfo.makeRoutines.count
            if numberOfRow == 0 {
                heightOfTableView.constant = Constants.defaultHeightOfTableview
                hiddenView.isHidden = false
            } else {
                heightOfTableView.constant = CGFloat(numberOfRow) * Constants.heightOfRow
                    + Constants.heightOfHeader + Constants.heightOfFooter
            }
        } else {
            numberOfRow = Constants.shortenNumberOfRow
            heightOfTableView.constant = Constants.defaultHeightOfTableview
        }
        weekInfoTableView.reloadData()
    }
    
    private func changeHeightTableView() {
        guard let weekInfo = weekInfo else { return }
        if weekInfo.makeRoutines.count > Constants.shortenNumberOfRow {
            let expandHeight = CGFloat(weekInfo.makeRoutines.count - Constants.shortenNumberOfRow) * Constants.heightOfRow
            if isExpanded {
                numberOfRow = Constants.shortenNumberOfRow
                heightOfScrollView.constant -= expandHeight
                heightOfTableView.constant -= expandHeight
            } else {
                numberOfRow = weekInfo.makeRoutines.count
                heightOfScrollView.constant += expandHeight
                heightOfTableView.constant += expandHeight
            }
        }
    }
    
    @objc private func expandTableView() {
        changeHeightTableView()
        isExpanded = !isExpanded
        weekInfoTableView.reloadData()
        view.setNeedsLayout()
    }
    
    private func setUpView() {
        // numberRoutineTodayLabel - Show number of routines for today (both done and not done routine)
        let todayInfo = DayInfoDatabase.shared.getADayInfo(dateStr: Date().getFullDateString())
        let todayRoutineNumber = Int(todayInfo?.completion.routineNumber ?? 0)
        let todayRoutineDone = Int(todayInfo?.completion.routineDone ?? 0)
        numberRoutineTodayLabel.text = "\(todayRoutineDone)/\(todayRoutineNumber)"
        // totalNumberOfRoutinesLabel - Show all routines was created
        totalNumberOfRoutinesLabel.text = "\(RoutineDatabase.shared.getAllRoutine().count)"
        // totalNumberOfCompleteRoutineLabel - Show all routines was finished on someday before
        var totalRoutineDoneTimes = 0.0
        var totalRoutineComplete = 0.0
        for dayInfo in DayInfoDatabase.shared.getAllDayInfo() {
            for makeRou in dayInfo.makeRoutines {
                totalRoutineDoneTimes += 1
                if makeRou.isComplete {
                    totalRoutineComplete += 1
                }
            }
        }
        totalNumberOfCompleteRoutineLabel.text = "\(Int(totalRoutineComplete))"
        // completionProgessBar - Display current progess finish routine on week
        if totalRoutineDoneTimes == 0 {
            completionProgessBar.value = 0
        } else {
            completionProgessBar.value = CGFloat(totalRoutineComplete / totalRoutineDoneTimes * 100)
        }
        // totalNumberOfNotDoneRouLabel - Show number of routines was not done before
        totalNumberOfNotDoneRouLabel.text = "\(Int(totalRoutineDoneTimes - totalRoutineComplete))"
    }
}

extension StatisticAllController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weekInfo = weekInfo else {
            return UITableViewCell()
        }
        let cell: StatisticRoutineCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContentForCell(makeRoutine: weekInfo.makeRoutines[indexPath.row])
        return cell
    }
    
}

extension StatisticAllController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = StatisticRoutineHeaderCell.loadFromNib()
        headerCell.setContentForCell(days: daysInWeek,
                                     completion: weekInfo?.totalCurrentProgess ?? 0)
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.heightOfHeader
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerCell = StatisticRoutineFooterCell.loadFromNib()
        footerCell.setContentForCell(isExpanded: isExpanded)
        footerCell.expandButton.addTarget(self,
                                          action: #selector(expandTableView),
                                          for: .touchUpInside)
        return footerCell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.heightOfFooter
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightOfRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let makeRou =  weekInfo?.makeRoutines[indexPath.row] else { return }
        let controller = DetailRoutineController.instantiate().then {
            $0.nameRoutine = makeRou.routine.nameRoutine
            $0.idRoutine = makeRou.routine.idRoutine
            $0.targetWeek = "\(Int(makeRou.completion.doneCount))/\(Int(makeRou.completion.targetTime))"
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}
