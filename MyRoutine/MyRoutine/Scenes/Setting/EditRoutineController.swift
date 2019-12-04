//
//  EditRoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/19/19.
//  Copyright © 2019 huy. All rights reserved.
//

enum SectionEditRoutineTableView: Int {
    case infoSection = 0
    case deleteSection = 1
}

enum CellEditRoutineTableView: Int {
    case repeatCell = 0
    case dayStartCell = 1
    case targetCell = 2
    case remindCell = 3
    case periodCell = 4
}

final class EditRoutineController: UIViewController {
    
    // MARK: - Constants
    struct ConstantsEditRoutine {
        static let numberOfSection = 2
        static let numberOfRowInInfoSection = 5
        static let numberOfRowInDeleteSection = 1
        static let heightForHeader: CGFloat = 12
        static let numberOfRowInView: CGFloat = 13
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var infoRoutineTableView: UITableView!
    @IBOutlet private weak var nameRoutineLabel: UILabel!
    
    // MARK: - Variables
    var routine: RoutineModel?
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUpTableView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Support Method
    private func setUpData() {
        nameRoutineLabel.text = routine?.nameRoutine
        receiveNotification()
    }
    
    private func setUpTableView() {
        infoRoutineTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: RoutineComponentCell.self)
            $0.register(cellType: DeleteRoutineCell.self)
        }
    }
    
    private func receiveNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateRepeat(notification:)),
                                               name: NSNotification.Name(rawValue: "Repeat"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateRemind(notification:)),
                                               name: NSNotification.Name("Remind"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatePeriod(notification:)),
                                               name: NSNotification.Name(rawValue: "Period"),
                                               object: nil)
    }
    
    @objc private func updateRepeat(notification: Notification) {
        guard let mess = notification.userInfo, let msg = mess["message"] else { return }
        let repeatRoutine = MapperService.shared.convertAnyToObject(any: msg,
                                                                    typeOpject: [DayOfWeek].self) ?? []
        routine?.repeatRoutine = repeatRoutine
        infoRoutineTableView.reloadData()
    }
    
    @objc private func updateRemind(notification: Notification) {
        guard let mess = notification.userInfo, let msg = mess["message"] else { return }
        let remindRoutine = MapperService.shared.convertAnyToObject(any: msg,
                                                                    typeOpject: [RemindModel].self) ?? []
        routine?.remindRoutine = remindRoutine
        infoRoutineTableView.reloadData()
    }
    
    @objc private func updatePeriod(notification: Notification) {
        guard let mess = notification.userInfo, let msg = mess["message"],
            let periodRoutine = MapperService.shared.convertAnyToObject(any: msg,
                                                                        typeOpject: PeriodDay.self) else {
                                                                            return
        }
        routine?.periodRoutine = periodRoutine.value
        infoRoutineTableView.reloadData()
    }
    
    private func repeatRoutineToString(daysOfWeek: [DayOfWeek]) -> String {
        if daysOfWeek.count == Constants.numberDayOnWeek {
            return "Hàng ngày"
        } else {
            return daysOfWeek.map { $0.shortTitle }
                .reduce("", { $0 + " " + $1 })
        }
    }
    
    private func remindRoutineToString(remind: [RemindModel]) -> String {
        let checkRemind = remind.filter { $0.state }
        switch checkRemind.count {
        case 0: return "Tắt"
        case 1: return checkRemind[0].timeString
        default: return "\(checkRemind.count) lần / ngày"
        }
    }
    
    private func periodRoutineToString(period: PeriodDay?) -> String {
        return period?.title ?? "Sáng"
    }
    
    private func dayStartRoutineToStringDisplayOnView(dayStart: String) -> String {
        let date = dayStart.getDate(format: DateFormat.fullDateFormat.rawValue)
        return date.getStringDate()
    }
    
    // MARK: - Actions
    @IBAction func handleCancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleSaveButton(_ sender: Any) {
        guard let routine = routine else { return }
        RoutineDatabase.shared.updateRoutine(newRouine: routine)
        NotificationSerivce.shared.refreshLocalNotifications()
        navigationController?.popViewController(animated: true)
    }
}

extension EditRoutineController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ConstantsEditRoutine.numberOfSection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SectionEditRoutineTableView(rawValue: section) else { return 0 }
        switch sectionType {
        case .infoSection:
            return ConstantsEditRoutine.numberOfRowInInfoSection
        case .deleteSection:
            return ConstantsEditRoutine.numberOfRowInDeleteSection
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let routine = routine, let sectionType = SectionEditRoutineTableView(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch sectionType {
        case .infoSection:
            guard let cellType = CellEditRoutineTableView(rawValue: indexPath.row) else {
                return UITableViewCell()
            }
            let cell: RoutineComponentCell = tableView.dequeueReusableCell(for: indexPath)
            switch cellType {
            case .repeatCell:
                cell.setUp(iconSetting: Constants.iconCategory[indexPath.row],
                           setting: Constants.defaultComponents[indexPath.row],
                           state: repeatRoutineToString(daysOfWeek: routine.repeatRoutine))
                
            case .dayStartCell:
                cell.setUp(iconSetting: Constants.iconCategory[indexPath.row],
                           setting: Constants.defaultComponents[indexPath.row],
                           state: dayStartRoutineToStringDisplayOnView(dayStart: routine.dayStart))
                
            case .targetCell:
                cell.setUp(iconSetting: Constants.iconCategory[indexPath.row],
                           setting: Constants.defaultComponents[indexPath.row],
                           state: "\(routine.targetRoutine) lần / ngày")
                
            case .remindCell:
                cell.setUp(iconSetting: Constants.iconCategory[indexPath.row],
                           setting: Constants.defaultComponents[indexPath.row],
                           state: remindRoutineToString(remind: routine.remindRoutine))
                
            case .periodCell:
                cell.setUp(iconSetting: Constants.iconCategory[indexPath.row],
                           setting:  Constants.defaultComponents[indexPath.row],
                           state: periodRoutineToString(period: PeriodDay(rawValue: routine.periodRoutine)))
            }
            return cell
        case .deleteSection:
            let cell: DeleteRoutineCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}

extension EditRoutineController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView().then {
            $0.backgroundColor = UIColor.clear
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ConstantsEditRoutine.heightForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height / ConstantsEditRoutine.numberOfRowInView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let routine = routine, let sectionType = SectionEditRoutineTableView(rawValue: indexPath.section) else { return }
        switch sectionType {
        case .infoSection:
            guard let cellType = CellEditRoutineTableView(rawValue: indexPath.row) else { return }
            switch cellType {
            case .repeatCell:
                let controller = RepeatOptionController.instantiate()
                controller.checkSelect = MapperService.shared.daysOfWeekToBoolCheck(days: routine.repeatRoutine)
                navigationController?.pushViewController(controller, animated: true)
                
            case .dayStartCell:
                PickerViewControl.showDatePicker(type: .date,
                                                 title: "Ngày bắt đầu") {[weak self] dateChange in
                                                    if let date = dateChange {
                                                        self?.routine?.dayStart = date.getFullDateString()
                                                        self?.infoRoutineTableView.reloadData()
                                                    }
                }
                
            case .targetCell:
                AlertViewControl.showInputAlert(title: "Số lần",
                                                message: "Số lần thực hiện trong ngày",
                                                cancelButtonTitle: "Huỷ",
                                                inputType: .numberPad,
                                                placeHolder: "Nhập giá trị",
                                                saveButtonTitle: "Xong") {[weak self] (inputValue) in
                                                    if !inputValue.isEmpty {
                                                        self?.routine?.targetRoutine = inputValue.int
                                                        self?.infoRoutineTableView.reloadData()
                                                    }
                }
                
            case .remindCell:
                let controller = RemindRoutineController.instantiate()
                controller.reminds = routine.remindRoutine
                navigationController?.pushViewController(controller, animated: true)
                
            case .periodCell:
                let controller = DayPeriodController.instantiate()
                controller.periodRoutine = PeriodDay(rawValue: routine.periodRoutine) ?? PeriodDay.Morning
                navigationController?.pushViewController(controller, animated: true)
            }
            
        case .deleteSection:
            print("XOÁ")
        }
    }
}

extension EditRoutineController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.setting
}
