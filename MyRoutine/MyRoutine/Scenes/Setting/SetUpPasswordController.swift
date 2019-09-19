//
//  SetUpPasswordController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/15/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class SetUpPasswordController: UIViewController {
    
    // MARK: - Constants
    struct Constants {
        static let numberOfSections = 3
        static let numberOfRowInSections = [1, 1, 1]
        static let heightForRow: CGFloat = 60
        static let heightForHeader: CGFloat = 17
        static let titlePasswordMode = "Khoá ứng dụng"
        static let titleTouchIDMode = "Mở khoá bằng TouchID"
    }

    // MARK: - Variables
    var checkPasswordOn = PasscodeService.shared.checkTurnOnPasscode()
    
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
        return Constants.numberOfRowInSections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let typeCell = CellSetUpPasswordTableView(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch typeCell {
        case .passWordMode:
            let cell: SetUpPasswordCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(passwordMode: Constants.titlePasswordMode,
                                   state: checkPasswordOn, isDisable: false)
            cell.didChangeSwitch = {[unowned self] changeState in
                self.checkPasswordOn = changeState
                self.setUpPwTableView.reloadData()
                PasscodeService.shared.turnOnPasscodeMode(turnOn: changeState)
                if changeState && !PasscodeService.shared.checkExistPasscode() {
                    let controller = PasswordInputContrroller.instantiate()
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
            return cell
            
        case .touchIDMode:
            let cell: SetUpPasswordCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(passwordMode: Constants.titleTouchIDMode,
                                   state: false, isDisable: !checkPasswordOn)
            cell.didChangeSwitch = {[unowned self] changeState in
                TouchIDService.shared.turnOnTouchID(turnOn: changeState)
            }
            return cell
            
        case .changePassword:
            let cell: ChangePasswordCell = tableView.dequeueReusableCell(for: indexPath)
            cell.disableContent(isDisable: !checkPasswordOn)
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
}

extension SetUpPasswordController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.heightForHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView().then {
            $0.backgroundColor = UIColor.backgroundColor
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let typeCell = CellSetUpPasswordTableView(rawValue: indexPath.section) else { return }
        switch typeCell {
        case .changePassword:
            let controller = PasswordInputContrroller.instantiate()
            controller.typeOfInputPasscode = .newPasscode
            navigationController?.pushViewController(controller, animated: true)
        default:
            break
        }
    }
}

extension SetUpPasswordController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.setting
}
