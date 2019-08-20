//
//  RepeatOptionController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/20/19.
//  Copyright © 2019 huy. All rights reserved.
//

class RepeatOptionController: UIViewController {
    
    // MARK: - Variables
    var checkSelect = [true, true, true, true, true, true, true]
   
    // MARK: - Outlets
    @IBOutlet weak var repeatOptionTbv: UITableView!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    // MARK: - Set Up
    func setUpTableView() {
        repeatOptionTbv.dataSource = self
        repeatOptionTbv.delegate = self
        repeatOptionTbv.register(cellType: SelectionCell.self)
    }

    // MARK: - Actions
    @IBAction func handleBackButton(_ sender: Any) {
        let repeatOption = MapperService.shared.boolCheckToDaysOfWeek(check: checkSelect)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Repeat"),
                                        object: nil,
                                        userInfo: ["message": repeatOption])
        navigationController?.popViewController(animated: true)
    }

}

extension RepeatOptionController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.allWeek.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SelectionCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setOption(option: Date.getWeekDay(day: Constants.allWeek[indexPath.row].value),
                       choose: checkSelect[indexPath.row])
        return cell
    }
    
}

extension RepeatOptionController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkSelect[indexPath.row] = !checkSelect[indexPath.row]
        repeatOptionTbv.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height / 13
    }
    
}

extension RepeatOptionController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.diary
}
