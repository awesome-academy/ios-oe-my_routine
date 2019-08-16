//
//  RemindController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/9/19.
//  Copyright © 2019 huy. All rights reserved.
//

class RemindController: UIViewController {
    
    // MARK: - Variables
    var remind = [RemindModel]()
    
    // MARK: - Outlets
    @IBOutlet weak var btnEditOL: UIButton!
    @IBOutlet weak var tbviewRemind: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTbv()
    }
    
    // MARK: - Actions
    @IBAction func btnEdit(_ sender: Any) {
        if tbviewRemind.isEditing {
            btnEditOL.setTitle("Sửa", for: .normal)
        } else {
            btnEditOL.setTitle("Xong", for: .normal)
        }
        tbviewRemind.isEditing = !tbviewRemind.isEditing
    }
    @IBAction func btnBack(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Remind"), object: nil, userInfo: ["message": remind])
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Support Method
    func setUpTbv() {
        tbviewRemind.dataSource = self
        tbviewRemind.delegate = self
        tbviewRemind.register(UINib(nibName: "CellRemind", bundle: nil), forCellReuseIdentifier: "cell")
        tbviewRemind.register(UINib(nibName: "CellAddRemind", bundle: nil), forCellReuseIdentifier: "cellAdd")
    }
}

// MARK: - TableView
extension RemindController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 1 : remind.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CellRemind else {
                return UITableViewCell()
            }
            cell.setUp(timeRemind: remind[indexPath.row].timeString, switchOn: remind[indexPath.row].state)
            cell.didChangeSwitch = {[weak self] (change) in
                self?.remind[indexPath.row].state = change
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellAdd") as? CellAddRemind else {
                return UITableViewCell()
            }
            return cell
        }
    }
}

extension RemindController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height/13
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PickerViewControl.showDatePicker(type: .time, title: "Nhắc  ") {[weak self] (hourChange) in
            if let hour = hourChange {
                if indexPath.section == 0 {
                    self?.remind[indexPath.row].timeString = hour.getStringHour()
                } else {
                    self?.remind.append(RemindModel(timeString: hour.getStringHour(), state: true))
                }
                self?.tbviewRemind.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            remind.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .delete
        } else {
            return .none
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? true : false
    }
}
