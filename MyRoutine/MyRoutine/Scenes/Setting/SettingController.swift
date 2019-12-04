//
//  SettingController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/1/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class SettingController: UIViewController {
    
    // MARK: - Constants
    static let heightForRow: CGFloat = 60
    static let numberOfRow = 2
    
    // MARK: - Outlets
    @IBOutlet weak var settingTableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func setUpTableView() {
        settingTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: ManageRoutineCell.self)
            $0.register(cellType: PasswordSettingCell.self)
        }
    }
}

extension SettingController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingController.numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let typeCell = CellSettingTableView(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        switch typeCell {
        case .manageRoutine:
            let cell: ManageRoutineCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .passwordMode:
            let cell: PasswordSettingCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}

extension SettingController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingController.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let typeCell = CellSettingTableView(rawValue: indexPath.row) else { return }
        switch typeCell {
        case .manageRoutine:
            let controller = ManageRoutineController.instantiate()
            navigationController?.pushViewController(controller, animated: true)
        case .passwordMode:
            let controller = SetUpPasswordController.instantiate()
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

