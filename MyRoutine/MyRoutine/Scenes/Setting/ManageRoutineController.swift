//
//  ManageRoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/15/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class ManageRoutineController: UIViewController {
    
    // MARK: - Constants
    static let heightForRow: CGFloat = 65
    
    // MARK: - Variables:
    var routine = RoutineDatabase.shared.getAllRoutine()
    
    // MARK: - Outlets
    @IBOutlet private weak var routineSearchBar: UISearchBar!
    @IBOutlet private weak var routineTableView: UITableView!
    @IBOutlet private weak var hiddenView: UIView!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - Support Method
    private func setUpView() {
        hiddenView.isHidden = !routine.isEmpty
        routineTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.isEditing = true
            $0.register(cellType: EditRoutineCell.self)
        }
    }
    
    // MARK: - Actions
    @IBAction func handleBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension ManageRoutineController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EditRoutineCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContentCell(routine: routine[indexPath.row])
        return cell
    }
}

extension ManageRoutineController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ManageRoutineController.heightForRow
    }
}

extension ManageRoutineController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.setting
}
