//
//  DayPeriodController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/30/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class DayPeriodController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var periodDayTableView: UITableView!
    
    // MARK: - Constants
    static let numberOfRowInView: CGFloat = 13
    
    // MARK: - Variables
    let periodDay: [PeriodDay] = [.Morning, .Midday, .Afternoon, .Night]
    var periodRoutine = PeriodDay.Morning
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    // MARK: - Support Methods
    private func setUpTableView() {
        periodDayTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: SelectionCell.self)
        }
    }
    
    // MARK: - Actions
    @IBAction func handleButtonBack(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Period"),
                                        object: nil,
                                        userInfo: ["message": periodRoutine])
        navigationController?.popViewController(animated: true)
    }
}

extension DayPeriodController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return periodDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SelectionCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setTitleAndStateOption(option: periodDay[indexPath.row].title,
                                    isSelected: periodDay[indexPath.row] == periodRoutine)
        return cell
    }
}

extension DayPeriodController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height / DayPeriodController.numberOfRowInView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        periodRoutine = periodDay[indexPath.row]
        periodDayTableView.reloadData()
    }
}

extension DayPeriodController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.diary
}
