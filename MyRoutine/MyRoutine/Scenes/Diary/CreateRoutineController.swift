//
//  CreateRoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/16/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class CreateRoutineController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var suggestCollectionView: UICollectionView!
    @IBOutlet private weak var stateRoutineTableView: UITableView!
    @IBOutlet private weak var nameRoutineTf: UITextField!
    
    // MARK: - Constants
    static let numberRowInView: CGFloat = 13
    
    // MARK: - Variables
    var state = Constants.defaultNewRoutine
    var routine =  RoutineModel.defautInit()

    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Denit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup
    func setUp() {
        nameRoutineTf.delegate = self
        nameRoutineTf.returnKeyType = .done
        setUpCollectionView()
        setUpTableView()
        receiveNotification()
    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout().then {
            let itemWidth = suggestCollectionView.witdh * 2 / 5
            let itemHeight = suggestCollectionView.height
            $0.itemSize = CGSize(width: itemWidth, height: itemHeight)
            $0.scrollDirection = .horizontal
        }
        suggestCollectionView.do {
            $0.collectionViewLayout = layout
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: SuggestionViewCell.self)
        }
    }
    
    func setUpTableView() {
        stateRoutineTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: RoutineComponentCell.self)
        }
    }
    
    // MARK: - Actions
    @IBAction func handleAddRoutineButton(_ sender: Any) {
        if nameRoutineTf.text!.isEmpty {
            AlertViewControl.showQuickSystemAlert(title: "Đã xảy ra lỗi",
                                                  message: "Không được để trống tên",
                                                  cancelButtonTitle: "Ok")
        } else {
            routine.nameRoutine = nameRoutineTf.text!
            RoutineDatabase.shared.saveRoutinetoDB(routine) { routine in
                if routine == nil {
                    AlertViewControl.showQuickSystemAlert(title: "Đã xảy ra lỗi",
                                                          message: nil,
                                                          cancelButtonTitle: "Ok")
                    return
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateDayInfo"),
                                            object: nil,
                                            userInfo: ["message": routine])
            NotificationSerivce.shared.addNotificationARoutine(routine: routine)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - SupportMethod
    func receiveNotification() {
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
    
    @objc func updatePeriod(notification: Notification) {
        guard let mess = notification.userInfo, let msg = mess["message"],
              let periodRoutine = MapperService.shared.convertAnyToObject(any: msg,
                                                                          typeOpject: PeriodDay.self) else {
            return
        }
        routine.periodRoutine = periodRoutine.value
        state[4] = periodRoutine.title
        stateRoutineTableView.reloadData()
        
    }
    
    @objc func updateRepeat(notification: Notification) {
        guard let mess = notification.userInfo, let msg = mess["message"] else { return }
        let repeatRoutine = MapperService.shared.convertAnyToObject(any: msg,
                                                                    typeOpject: [DayOfWeek].self) ?? []
        routine.repeatRoutine = repeatRoutine
        state[0] = changeRepeatState(daysOfWeek: repeatRoutine)
        stateRoutineTableView.reloadData()
        
    }
    
    @objc func updateRemind(notification: Notification) {
        guard let mess = notification.userInfo, let msg = mess["message"] else { return }
        let remindRoutine = MapperService.shared.convertAnyToObject(any: msg,
                                                                    typeOpject: [RemindModel].self) ?? []
        routine.remindRoutine = remindRoutine
        let checkRemind = remindRoutine.filter { $0.state }
        switch checkRemind.count {
        case 0: state[3] = "Tắt"
        case 1: state[3] = checkRemind[0].timeString
        default: state[3] = "\(checkRemind.count) lần / ngày"
        }
        stateRoutineTableView.reloadData()
    }
    
    func changeRepeatState(daysOfWeek: [DayOfWeek]) -> String {
        if daysOfWeek.count == Constants.numberDayOnWeek {
            return "Hàng ngày"
        } else {
            return daysOfWeek.map { $0.shortTitle }
                             .reduce("", { $0 + " " + $1 })
        }
    }

}

// MARK: - CollectionView
extension CreateRoutineController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.suggestNameRoutine.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SuggestionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setUp(icon: Constants.suggestIcon[indexPath.row],
                   suggest: Constants.suggestNameRoutine[indexPath.row])
        return cell
    }
}

extension CreateRoutineController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nameRoutineTf.text = Constants.suggestNameRoutine[indexPath.row]
    }
}

// MARK: - TableView
extension CreateRoutineController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.defaultComponents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RoutineComponentCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setUp(iconSetting: Constants.iconCategory[indexPath.row],
                   setting: Constants.defaultComponents[indexPath.row],
                   state: state[indexPath.row])
        return cell
    }
}

extension CreateRoutineController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height / CreateRoutineController.numberRowInView 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let typeCell = CellStateRoutineTableView(rawValue: indexPath.row) else { return }
        switch typeCell {
        case .repeatCell:
            let controller = RepeatOptionController.instantiate()
            controller.checkSelect = MapperService.shared.daysOfWeekToBoolCheck(days: routine.repeatRoutine)
            navigationController?.pushViewController(controller, animated: true)
        case .dayStartCell:
            PickerViewControl.showDatePicker(type: .date,
                                             title: "Ngày bắt đầu") {[weak self] dateChange in
                if let date = dateChange {
                    let dateStr = date.getStringDate()
                    self?.state[1] = dateStr == Date().getStringDate() ? "Hôm nay" : dateStr
                    self?.routine.dayStart = date.getFullDateString()
                    self?.stateRoutineTableView.reloadData()
                }
            }
        case .remindCell:
            let controller = RemindRoutineController.instantiate()
            controller.reminds = routine.remindRoutine
            navigationController?.pushViewController(controller, animated: true)
        case .targetCell:
            AlertViewControl.showInputAlert(title: "Số lần",
                                             message: "Số lần thực hiện trong ngày",
                                             cancelButtonTitle: "Huỷ",
                                             inputType: .numberPad,
                                             placeHolder: "Nhập giá trị",
                                             saveButtonTitle: "Xong") {[weak self] (inputValue) in
                if !inputValue.isEmpty {
                    self?.state[2] = inputValue + " lần / ngày"
                    self?.routine.targetRoutine = inputValue.int
                    self?.stateRoutineTableView.reloadData()
                }
            }
        case .periodCell:
            let controller = DayPeriodController.instantiate()
            controller.periodRoutine = PeriodDay(rawValue: routine.periodRoutine) ?? PeriodDay.Morning
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - Textfield
extension CreateRoutineController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateRoutineController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.diary
}
