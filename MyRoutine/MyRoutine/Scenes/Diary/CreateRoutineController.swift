//
//  CreateRoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/16/19.
//  Copyright © 2019 huy. All rights reserved.
//

class CreateRoutineController: UIViewController {
    
    // MARK: - Variables
    var state = Constants.defaultNewRoutine
    var repeatDay = Constants.allWeek
    var repeatWeek = 1
    var routine =  RoutineModel.defautInit()
    
    // MARK: - Outlets
    @IBOutlet weak var suggestCollectionView: UICollectionView!
    @IBOutlet weak var stateRoutineTableView: UITableView!
    @IBOutlet weak var nameRoutineTf: UITextField!

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
        let layout = UICollectionViewFlowLayout()
        let itemWidth = suggestCollectionView.witdh * 2 / 5
        let itemHeight = suggestCollectionView.height
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .horizontal
        suggestCollectionView.collectionViewLayout = layout
        suggestCollectionView.dataSource = self
        suggestCollectionView.delegate = self
        suggestCollectionView.register(cellType: SuggestionViewCell.self)
    }
    
    func setUpTableView() {
        stateRoutineTableView.dataSource = self
        stateRoutineTableView.delegate = self
        stateRoutineTableView.register(cellType: RoutineComponentCell.self)
    }
    
    // MARK: - SupportMethod
    func receiveNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateRepeat(notification:)),
                                               name: NSNotification.Name(rawValue: "Repeat"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateRemind(notification:)),
                                               name: NSNotification.Name("Remind"),
                                               object: nil)
        
    }
    
    @objc func updateRepeat(notification: Notification) {
        if let mess = notification.userInfo, let msg = mess["message"] {
            let repeatRoutine = MapperService.shared.convertAnyToObject(any: msg,
                                                                        typeOpject: [DayOfWeek].self) ?? []
            routine.repeatRoutine = repeatRoutine
            state[0] = changeRepeatState(daysOfWeek: repeatRoutine)
            stateRoutineTableView.reloadData()
        }
    }
    
    @objc func updateRemind(notification: Notification) {
        if let mess = notification.userInfo, let msg = mess["message"] {
            let remindRoutine = MapperService.shared.convertAnyToObject(any: msg,
                                                                        typeOpject: [RemindModel].self) ?? []
            routine.remindRoutine = remindRoutine
            let check = remindRoutine.filter { $0.state }.count
            switch check {
            case 0: state[3] = "Tắt"
            case 1: state[3] = remindRoutine[0].timeString
            default: state[3] = "\(check) lần / ngày"
            }
            stateRoutineTableView.reloadData()
        }
    }
    
    func changeRepeatState(daysOfWeek: [DayOfWeek]) -> String {
        if daysOfWeek.count == 7 {
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
        return view.height / 13
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let controller = RepeatOptionController.instantiate()
            controller.checkSelect = MapperService.shared.daysOfWeekToBoolCheck(days: routine.repeatRoutine)
            navigationController?.pushViewController(controller, animated: true)
        case 1:
            PickerViewControl.showDatePicker(type: .date,
                                             title: "Ngày bắt đầu") {[weak self] dateChange in
                if let date = dateChange?.getStringDate() {
                    self?.state[1] = date == Date().getStringDate() ? "Hôm nay" : date
                    self?.routine.dayStart = date
                    self?.stateRoutineTableView.reloadData()
                }
            }
        case 3:
            let controller = RemindRoutineController.instantiate()
            controller.reminds = routine.remindRoutine
            navigationController?.pushViewController(controller, animated: true)
        default:
            return
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
