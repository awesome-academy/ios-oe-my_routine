//
//  DayPeriodController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/9/19.
//  Copyright © 2019 huy. All rights reserved.
//

class DayPeriodController: UIViewController {
    
    // MARK: - Variables
    let period = ["Sáng", "Chiều", "Tối", "Mọi lúc"]
    var state = "Sáng"
    
    // MARK: - Outlets
    @IBOutlet weak var tbvView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTbv()
    }
    
    // MARK: - Actions
    @IBAction func btnBack(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Period"), object: nil, userInfo: ["message": state])
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Support Method
    func setUpTbv() {
        tbvView.dataSource = self
        tbvView.delegate = self
        tbvView.register(UINib(nibName: "CellOption", bundle: nil), forCellReuseIdentifier: "CellOption")
    }
}

// MARK: - TableView
extension DayPeriodController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return period.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellOption") as? CellOption else {
            return UITableViewCell()
        }
        cell.setOption(option: period[indexPath.row])
        if period[indexPath.row] == state {
            cell.imageCheck.isHidden = false
        } else {
            cell.imageCheck.isHidden = true
        }
        return cell
    }
    
}

extension DayPeriodController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height/13
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        state = period[indexPath.row]
        tbvView.reloadData()
    }
}
