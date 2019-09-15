//
//  SetUpPasswordController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/15/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class SetUpPasswordController: UIViewController {
    
    // MARK: - Constants
    static let numberOfSections = 3
    static let numberOfRowInSections = [1, 1, 1]
    static let heightForRow: CGFloat = 60
    static let heightForHeader: CGFloat = 17

    // MARK: - Variables
    var checkPasswordOn = false
    
    // MARK: - Outlets
    @IBOutlet weak var setUpPwTableView: UITableView!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    private func setUpTableView() {
        setUpPwTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: SetUpPasswordCell.self)
            $0.register(cellType: ChangePasswordCell.self)
        }
    }
    
    // MARK: - Actions
    @IBAction func handleBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension SetUpPasswordController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SetUpPasswordController.numberOfRowInSections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let typeCell = CellSetUpPasswordTableView(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch typeCell {
        case .passWordMode:
            let cell: SetUpPasswordCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(passwordMode: "Khoá ứng dụng", state: checkPasswordOn, isDisable: false)
            cell.didChangeSwitch = {[weak self] changeState in
                self?.checkPasswordOn = changeState
                self?.setUpPwTableView.reloadData()
            }
            return cell
        case .touchIDMode:
            let cell: SetUpPasswordCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(passwordMode: "Mở khoá bằng TouchID", state: false, isDisable: !checkPasswordOn)
            return cell
        case .changePassword:
            let cell: ChangePasswordCell = tableView.dequeueReusableCell(for: indexPath)
            cell.disableContent(isDisable: !checkPasswordOn)
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SetUpPasswordController.numberOfSections
    }
    
}

extension SetUpPasswordController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SetUpPasswordController.heightForRow
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SetUpPasswordController.heightForHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView().then {
            $0.backgroundColor = UIColor(red: 235/255, green: 235/255,
                                         blue: 235/255, alpha: 0)
        }
        return view
    }
}

extension SetUpPasswordController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.setting
}
