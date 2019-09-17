//
//  DetailRoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/17/19.
//  Copyright © 2019 huy. All rights reserved.
//

import Parchment

final class DetailRoutineController: UIViewController {
    
    // MARK: - Constants
    struct Constants {
        static let numberOfPageController = 2
        static let titleFirstPage = "Thống kê"
        static let titleSecondPage = "Ghi chú"
        static let font = UIFont(name: "Helvetica Neue", size: 17)!
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var nameRoutineLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Variables
    private let statisticController = StatisticARoutineController.instantiate()
    private let takeNote = NoteRoutineController.instantiate()
    private lazy var viewControllers = [statisticController, takeNote]
    var nameRoutine = ""
    var idRoutine = ""
    var targetWeek = ""
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Support Method
    private func setUp() {
        nameRoutineLabel.text = nameRoutine
        let statistic = StatisticARoutineModel(dayInfos: DayInfoDatabase.shared.getAllDayInfo(),
                                               routineID: idRoutine)
        statisticController.do {
            $0.title = Constants.titleFirstPage
            $0.statisticARouine = statistic
            $0.weekTarget = targetWeek
        }
        takeNote.do {
            $0.title = Constants.titleSecondPage
            $0.routine = RoutineDatabase.shared.getRoutineByID(ID: idRoutine)
        }
        let pagingViewController = FixedPagingViewController(viewControllers: viewControllers).then {
            $0.delegate = self
            $0.view.frame = CGRect(x: 0, y: 0,
                                   width: SystemInfo.screenWidth,
                                   height: SystemInfo.screenHeight)
            $0.font = Constants.font
            $0.selectedFont = Constants.font
            $0.indicatorColor = UIColor.seclectedColor
            $0.selectedTextColor = UIColor.seclectedColor
            $0.didMove(toParent: self)
        }
        addChild(pagingViewController)
        containerView.addSubview(pagingViewController.view)
    }
    
    // MARK: - Actions
    @IBAction func handleBackButton(_ sender: Any) {
        if let newRou = takeNote.routine {
            RoutineDatabase.shared.updateRoutine(newRouine: newRou)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension DetailRoutineController: PagingViewControllerDelegate {
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, widthForPagingItem pagingItem: T, isSelected: Bool) -> CGFloat? {
        return view.witdh / CGFloat(Constants.numberOfPageController)
    }
}

extension DetailRoutineController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.statisticARoutine
}
