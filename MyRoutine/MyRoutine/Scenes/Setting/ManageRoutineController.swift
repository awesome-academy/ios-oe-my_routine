//
//  ManageRoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/15/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class ManageRoutineController: UIViewController {
    
    // MARK: - Constants
    static let heightForRow: CGFloat = 70
    
    // MARK: - Variables:
    var allRoutine = RoutineDatabase.shared.getAllRoutine()
    
    // MARK: - Outlets
    @IBOutlet private weak var routineTableView: UITableView!
    @IBOutlet private weak var hiddenView: UIView!
    @IBOutlet weak var routineSearchBar: UISearchBar!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - Support Method
    private func setUpView() {
        hiddenView.isHidden = !allRoutine.isEmpty
        routineTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: EditRoutineCell.self)
        }
    }
    
    // MARK: - Actions
    @IBAction func handleBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleDeleteButton(_ sender: Any) {
        deleteButton.do {
            $0.setTitleColor(routineTableView.isEditing ? UIColor.red : UIColor.green, for: .normal)
            $0.setTitle(routineTableView.isEditing ? "Xoá" : "Xong",
                        for: .normal)
        }
        routineTableView.isEditing = !routineTableView.isEditing
    }
}

extension ManageRoutineController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRoutine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EditRoutineCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContentCell(routine: allRoutine[indexPath.row])
        return cell
    }
}

extension ManageRoutineController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ManageRoutineController.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EditRoutineController.instantiate()
        controller.routine = allRoutine[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.allRoutine.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            RoutineDatabase.shared.removeAllRoutine()
            allRoutine.forEach {
                RoutineDatabase.shared.saveRoutinetoDB($0)
            }
        }
    }
}

extension ManageRoutineController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.setting
}
