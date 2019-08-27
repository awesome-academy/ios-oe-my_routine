//
//  DiaryController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/1/19.
//  Copyright © 2019 huy. All rights reserved.
//

class DiaryController: UIViewController {
    
    // MARK: - Variables
    var routine = [RoutineModel]()
    let dateArray =  Date.returnArrayOfDate(number: 14).map {
        $0.getStrDateFormat(format: "dd")
    }
    let weekDays =  Date.returnArrayOfDate(number: 14).map {
        DayOfWeek(rawValue: $0.weekday)?.shortTitle
    }
    
    // MARK: - Outlets
    @IBOutlet weak var dateCollectionView: UICollectionView!
    @IBOutlet weak var routineTableView: UITableView!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpTableView()
    }
    
    // MARK: - Actions
    @IBAction func handleButtonCreate(_ sender: Any) {
        let controller = UINavigationController()
        controller.navigationBar.isHidden = true
        controller.viewControllers = [CreateRoutineController.instantiate()]
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Support Function
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout().then {
            $0.sectionInset = UIEdgeInsets(top: 2, left: 7, bottom: 2, right: 7)
            $0.minimumLineSpacing = 5
            let heightItem = dateCollectionView.height * 7 / 8
            let witdthItem = dateCollectionView.witdh / 7
            $0.itemSize = CGSize(width: witdthItem, height: heightItem)
            $0.scrollDirection = .horizontal
        }
        dateCollectionView.do {
            $0.collectionViewLayout = layout
            $0.dataSource = self
            $0.register(cellType: DateCell.self)
        }
        
    }
    
    func setUpTableView() {
        routineTableView.dataSource = self
        routineTableView.delegate = self
        routineTableView.register(cellType: RoutineDiaryCelll.self)
    }
}

extension DiaryController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DateCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setDateForCell(date: dateArray[indexPath.row],
                            weekDay: weekDays[indexPath.row] ?? "",
                            choose: false)
        return cell
    }
    
}

extension DiaryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RoutineDiaryCelll = tableView.dequeueReusableCell(for: indexPath)
        cell.setContentForCell(routine: routine[indexPath.row])
        return cell
    }

}

extension DiaryController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height / 10
    }
}

extension DiaryController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.diary
}
