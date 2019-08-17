//
//  RepeatController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/17/19.
//  Copyright © 2019 huy. All rights reserved.
//

import UIKit

class RepeatController: UIViewController {
    
    // MARK: - Variables
    let optiopDay = ["Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy", "Chủ Nhật"]
    let optionWeek = ["1 ngày một tuần", "2 ngày một tuần", "3 ngày một tuần", "4 ngày một tuần", "5 ngày một tuần", "6 ngày một tuần"]
    var checkOptionDay = [1, 2, 3, 4, 5, 6, 7]
    var checkOptionWeek = 1
    var kqua = RepeatModel()
    
    // MARK: - Outlets
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tbvOption: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        segment.selectedSegmentIndex = checkOptionWeek != 1 ? 1 : 0
    }
    
    @IBAction func reloadTbv(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            checkOptionDay = [1, 2, 3, 4, 5, 6, 7]
        } else {
            checkOptionWeek = 1
        }
        tbvOption.reloadData()
    }
    @IBAction func btnBack(_ sender: Any) {
        if segment.selectedSegmentIndex == 0 {
            kqua.type = 1
            for i in checkOptionDay {
                kqua.value.append(i)
            }
        } else {
            kqua.type = 2
            kqua.value.append(checkOptionWeek)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Repeat"),
                                        object: nil,
                                        userInfo: ["message": kqua])
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Supporting Method
    func setUpTableView() {
        tbvOption.dataSource = self
        tbvOption.delegate = self
        tbvOption.register(UINib(nibName: "CellOption", bundle: nil), forCellReuseIdentifier: "CellOption")
    }
    
}
extension RepeatController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segment.selectedSegmentIndex == 0 {
            return optiopDay.count
        } else {
            return optionWeek.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellOption") as? CellOption else {
            return UITableViewCell()
        }
        if segment.selectedSegmentIndex == 0 {
            cell.setOption(option: optiopDay[indexPath.row])
        } else {
            cell.setOption(option: optionWeek[indexPath.row])
        }
        if segment.selectedSegmentIndex == 0 {
            if checkOptionDay[indexPath.row] == indexPath.row + 1 {
                cell.imageCheck.isHidden = false
            } else {
                cell.imageCheck.isHidden = true
            }
        } else {
            if checkOptionWeek == indexPath.row + 1 {
                cell.imageCheck.isHidden = false
            } else {
                cell.imageCheck.isHidden = true
            }
        }
        return cell
    }
}

extension RepeatController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height/13
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segment.selectedSegmentIndex == 1 {
            checkOptionWeek = indexPath.row + 1
        } else {
            if checkOptionDay[indexPath.row] == indexPath.row + 1 {
                checkOptionDay[indexPath.row] = 0
            } else {
                checkOptionDay[indexPath.row] = indexPath.row + 1
            }
        }
        tbvOption.reloadData()
    }
}
