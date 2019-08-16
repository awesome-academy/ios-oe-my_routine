//
//  CreatRoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/3/19.
//  Copyright © 2019 huy. All rights reserved.
//

class CreatRoutineController: UIViewController {
    
    // MARK: - Variables
    let suggestIcon = ["⚽️", "🏃🏻‍♂️", "💪🏻", "📖", "🚴🏻‍♂️", "🏊🏻‍♂️"]
    let suggest = ["Đá bóng", "Chạy bộ", "Tập Gym", "Đọc sách", "Đạp xe", "Bơi lội"]
    let setting = ["Lặp lại", "Ngày bắt đầu", "Mục tiêu thực hiện", "Nhắc nhở", "Thời gian trong ngày"]
    let iconSetting = [ #imageLiteral(resourceName: "repeat"), #imageLiteral(resourceName: "calendar"), #imageLiteral(resourceName: "target"), #imageLiteral(resourceName: "remind"), #imageLiteral(resourceName: "time")]
    var state = ["Hàng ngày", "Hôm nay", "1 lần / ngày", "09:00", "Mọi lúc"]
    var repeatDay = [1, 2, 3, 4, 5, 6, 7]
    var repeatWeek = 1
    var routine =  RoutineModel(idRoutine: RoutineService.shared.getAllRoutine().count,
                                name: "NewRoutine",
                                dayStart: Date(), target: TargetModel(type: 1, number: 1),
                                repeatRoutine: RepeatModel(type: 1, value: [1, 2, 3, 4, 5, 6, 7]),
                                remind: [RemindModel(timeString: "9:00", state: true)],
                                period: 4,
                                doneCount: 0)
    
    // MARK: - Outlets
    @IBOutlet weak var tfNameRoutine: UITextField!
    @IBOutlet weak var tableViewSetting: UITableView!
    @IBOutlet weak var collectionViewSuggest: UICollectionView!
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Init & Denit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup
    func setUp() {
        tfNameRoutine.delegate = self
        tfNameRoutine.returnKeyType = .done
        setUpCollectionView()
        setUpTableView()
        receiveNotifi()
    }
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = collectionViewSuggest.witdh * 2/5
        let itemHeight = collectionViewSuggest.height
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .horizontal
        collectionViewSuggest.collectionViewLayout = layout
        collectionViewSuggest.dataSource = self
        collectionViewSuggest.delegate = self
        collectionViewSuggest.register(UINib(nibName: "CellSuggest", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    func setUpTableView() {
        tableViewSetting.dataSource = self
        tableViewSetting.delegate = self
        tableViewSetting.register(UINib(nibName: "CellSetUp", bundle: nil), forCellReuseIdentifier: "tbvcell")
    }
    
    // MARK: - Actions
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSave(_ sender: Any) {
        if let name = tfNameRoutine.text {
            if name.isEmpty {
                UIAlertController.showQuickSystemAlert(title: "Lỗi",
                                                       message: "Không được để trống tên",
                                                       cancelButtonTitle: "OK")
            } else {
                routine.nameRoutine = name
                RoutineService.shared.saveRoutinetoDB(routine)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Support Method
    func receiveNotifi() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateRepeat(notifi:)),
                                               name: NSNotification.Name(rawValue: "Repeat"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTarget(notifi:)),
                                               name: NSNotification.Name(rawValue: "Target"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePeriod(notifi:)),
                                               name: NSNotification.Name(rawValue: "Period"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateRemind(notifi:)),
                                               name: NSNotification.Name(rawValue: "Remind"), object: nil)
    }
    @objc func updateRepeat(notifi: Notification) {
        if let mess = notifi.userInfo, let msg = mess["message"] {
            guard let repeatRoutine = msg as? RepeatModel else {
                return
            }
            routine.repeatRoutine = repeatRoutine
            state[0] = xylyKQ(res: repeatRoutine)
            tableViewSetting.reloadData()
        }
    }
    @objc func updateTarget(notifi: Notification) {
        if let mess = notifi.userInfo, let msg = mess["message"] {
            guard let target = msg as? TargetModel else {
                return
            }
            routine.targetRoutine = target
            state[2] = target.type == 1 ? "\(target.number) lần/ngày" : "\(target.number) phút/ngày"
            tableViewSetting.reloadData()
        }
    }
    @objc func updateRemind(notifi: Notification) {
        if let mess = notifi.userInfo, let msg = mess["message"] {
            guard let remind = msg as? [RemindModel] else {
                return
            }
            routine.remindRoutine = remind
            let check = remind.filter { $0.state }.count
            switch check {
            case 0: state[3] = "Tắt"
            case 1: state[3] = remind[0].timeString
            default: state[3] = "\(check) lần / ngày"
            }
            tableViewSetting.reloadData()
        }
    }
    @objc func updatePeriod(notifi: Notification) {
        if let mess = notifi.userInfo, let msg = mess["message"] {
            state[4] = msg as? String ?? ""
            switch state[4] {
            case "Sáng": routine.periodRoutine = 1
            case "Chiều": routine.periodRoutine = 2
            case "Tối": routine.periodRoutine = 3
            default: routine.periodRoutine = 4
            }
            tableViewSetting.reloadData()
        }
    }
    func xylyKQ(res: RepeatModel) -> String {
        if res.type == 1 {
            repeatWeek = 1
            repeatDay = res.value.toArray(type: Int.self)
            if repeatDay == [1, 2, 3, 4, 5, 6, 7] {
                return "Hàng ngày"
            } else {
                let temp = res.value.filter { $0 != 0 }
                                    .map { $0.convertToDay }
                                    .reduce ("", { $0 + " " + $1 })
                return temp
            }
        } else {
            repeatWeek = res.value[0]
            repeatDay = [1, 2, 3, 4, 5, 6, 7] 
            return "\(repeatWeek) ngày trong tuần"
        }
    }
}

// MARK: - CollectionView
extension CreatRoutineController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggest.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CellSuggest else {
            return UICollectionViewCell()
        }
        cell.setUp(icon: suggestIcon[indexPath.row], suggest: suggest[indexPath.row])
        return cell
    }
}
extension CreatRoutineController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tfNameRoutine.text = suggest[indexPath.row]
    }
}

// MARK: - TableView
extension CreatRoutineController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setting.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tbvcell") as? CellSetUp else {
            return UITableViewCell()
        }
        cell.setUp(iconSetting: iconSetting[indexPath.row], setting: setting[indexPath.row], state: state[indexPath.row])
        return cell
    }
}
extension CreatRoutineController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height/13
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            guard let controller = Storyboards.diary.instantiateViewController(withIdentifier: "RepeatVC") as? RepeatController else {
                return
            }
            controller.checkOptionDay = repeatDay
            controller.checkOptionWeek = repeatWeek
            navigationController?.pushViewController(controller, animated: true)
        case 1:
            PickerViewControl.showDatePicker(type: .date, title: "Ngày bắt đầu") {[weak self] (dateChange) in
                if let date = dateChange {
                    if date.getStringDate() == Date().stringBy(format: "dd/MM/YYYY") {
                        self?.state[1] = "Hôm nay"
                    } else {
                        self?.state[1] = date.stringBy(format: "dd/MM/YYYY")
                    }
                    self?.routine.dayStart = date
                    self?.tableViewSetting.reloadData()
                }
            }
        case 2:
            guard let controller = Storyboards.diary.instantiateViewController(withIdentifier: "Target") as? TargetController else {
                return
            }
            controller.target = routine.targetRoutine
            navigationController?.pushViewController(controller, animated: true)
        case 3:
            guard let controller = Storyboards.diary.instantiateViewController(withIdentifier: "Remind") as? RemindController else {
                return
            }
            controller.remind = routine.remindRoutine
            navigationController?.pushViewController(controller, animated: true)
        case 4:
            guard let controller = Storyboards.diary.instantiateViewController(withIdentifier: "DayPeriod") as? DayPeriodController else {
                return
            }
            controller.state = state[4]
            navigationController?.pushViewController(controller, animated: true)
        default:
            return
        }
    }
}
extension CreatRoutineController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  
        return true
    }
}
