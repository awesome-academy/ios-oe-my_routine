//
//  RemindRoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/29/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class RemindRoutineController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var remindTableView: UITableView!
    
    // MARK: - Variables
    var reminds = [RemindModel]()
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    // MARK: - Support Methods
    func setUpTableView() {
        remindTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: RemindCell.self)
            $0.register(cellType: AddRemindCell.self)
        }
    }
    
    @IBAction func handleBackButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Remind"),
                                        object: nil,
                                        userInfo: ["message": reminds])
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleEditButton(_ sender: Any) {
        editButton.do {
            $0.setTitleColor(remindTableView.isEditing ?
                UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1) :
                UIColor(red: 149 / 255, green: 210 / 255, blue: 107 / 255, alpha: 1),
                             for: .normal)
            $0.setTitle(remindTableView.isEditing ? "Xoá" : "Xong",
                        for: .normal)
        }
        remindTableView.isEditing = !remindTableView.isEditing
    }
}

extension RemindRoutineController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Config.numberOfSectionRemindTableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let typeCell = CellRemindTableView(rawValue: section) else { return 0 }
        return typeCell == .remind ? reminds.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let typeCell = CellRemindTableView(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch typeCell {
        case .remind:
            let cell: RemindCell = tableView.dequeueReusableCell(for: indexPath)
            cell.do {
                $0.setRemindContent(timeRemind: reminds[indexPath.row].timeString,
                                    switchOn: reminds[indexPath.row].state)
                $0.didChangeSwitch = {[weak self] changeState in
                    self?.reminds[indexPath.row].state = changeState
                }
            }
            return cell
        case .addRemind:
            let cell: AddRemindCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension RemindRoutineController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView().then {
            $0.backgroundColor = .clear
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Config.heightForHeaderRemindTableView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Config.heightForRowRemindTableView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PickerViewControl.showDatePicker(type: .time,
                                         title: indexPath.section == 0 ? "Sửa" : "Thêm nhắc nhở") {[weak self] hourPicker in
            guard let hour = hourPicker else { return }
            if indexPath.section == 0 {
                self?.reminds[indexPath.row].timeString = hour.getStringHour()
            } else {
                self?.reminds.append(RemindModel(timeString: hour.getStringHour(),
                                                 state: true))
            }
            self?.remindTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            reminds.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return tableView.isEditing ? UITableViewCell.EditingStyle.delete : .none
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? true : false
    }
}

extension RemindRoutineController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.diary
}
