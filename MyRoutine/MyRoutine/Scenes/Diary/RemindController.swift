//
//  RemindController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/17/19.
//  Copyright © 2019 huy. All rights reserved.
//

import UIKit

class RemindController: UIViewController {
    
    // MARK: - Variables
    var remind = [RemindModel]()
    
    @IBOutlet weak var btnEditOutlet: UIButton!
    @IBOutlet weak var tbvRemind: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTbv()
    }

    @IBAction func btnBack(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Remind"),
                                        object: nil,
                                        userInfo: ["message": remind])
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        if tbvRemind.isEditing {
            btnEditOutlet.setTitle("Sửa", for: .normal)
        } else {
            btnEditOutlet.setTitle("Xong", for: .normal)
        }
        tbvRemind.isEditing = !tbvRemind.isEditing
    }
    
    func setUpTbv() {
        tbvRemind.dataSource = self
        tbvRemind.delegate = self
        tbvRemind.register(UINib(nibName: "CellRemind", bundle: nil),
                           forCellReuseIdentifier: "cell")
        tbvRemind.register(UINib(nibName: "CellAddRemind", bundle: nil),
                           forCellReuseIdentifier: "cellAdd")
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
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height/13
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PickerViewControl.showDatePicker(type: .time,
                                         title: "Nhắc nhở") {[weak self] hourChange in
            if let hour = hourChange {
                if indexPath.section == 0 {
                    self?.remind[indexPath.row].timeString = hour.getStringHour()
                } else {
                    self?.remind.append(RemindModel(timeString: hour.getStringHour(), state: true))
                }
                self?.tbvRemind.reloadData()
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
