//
//  DiaryController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/1/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class DiaryController: UIViewController {
   
    // MARK: - Constants
    static let numberOfDates = 14
    static let dates = DateService.shared.getArrayOfDate(numberOfDate: DiaryController.numberOfDates)
   
    // MARK: - Variables
    var dayInfo: DayInfo?
    var routine = [RoutineModel]()
    var chooseDate = DiaryController.numberOfDates - 2
    let dateNumber = DiaryController.dates.map {
        $0.getStrDateFormat(format: "dd")
    }
    let weekDays = DiaryController.dates.map {
        DayOfWeek(rawValue: $0.weekday)?.shortTitle
    }
    let dateString = DiaryController.dates.map {
        $0.getFullDateString()
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var dateCollectionView: UICollectionView!
    @IBOutlet private weak var routineTableView: UITableView!
    @IBOutlet private weak var emptyStateView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var completionRoutineProgessBar: UIProgressView!
    @IBOutlet private weak var completionRoutineLabel: UILabel!
    
   // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        dayInfo = getDayInfo(dateStr: dateString[DiaryController.numberOfDates - 2])
        setUpCollectionView()
        setUpTableView()
        updateView()
    }
   
    override func viewDidLayoutSubviews() {
        dateCollectionView.scrollToItem(at: IndexPath(row: DiaryController.numberOfDates - 2,
                                                      section: 0),
                                        at: .left, animated: true)
    }
   
    // MARK: - Actions
    @IBAction func handleButtonCreate(_ sender: Any) {
        let controller = UINavigationController().then {
            $0.navigationBar.isHidden = true
            $0.viewControllers = [CreateRoutineController.instantiate()]
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Support Function
    private func setUpCollectionView() {
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
            $0.delegate = self
            $0.register(cellType: DateCell.self)
        }
    }
    
    private func setUpTableView() {
        routineTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: RoutineDiaryCelll.self)
        }
    }
   
   private func getRoutineForDay(dateStr: String) -> [RoutineModel] {
      var routines = [RoutineModel]()
      let date = dateStr.getDate(format: Constants.dateFullFormat)
      for rou in RoutineDatabase.shared.getAllRoutine() {
         if rou.dayStart.getDate(format: Constants.dateFullFormat) <= date {
            for day in rou.repeatRoutine where day.value == date.weekday {
               routines.append(rou)
               break
            }
         }
      }
      return routines
   }
   
   private func getDayInfo(dateStr: String) -> DayInfo {
      guard let dayInfo = DayInfoDatabase.shared.getADayInfo(dateStr: dateStr) else {
         let routines = getRoutineForDay(dateStr: dateStr)
         var makeRoutines = [MakeRoutine]()
         for rou in routines {
            let completion = CompletionModel(targetTime: Float(rou.targetRoutine),
                                             doneCount: 0)
            makeRoutines.append(MakeRoutine(routine: rou,
                                            completion: completion))
         }
         let newDayInfo = DayInfo(date: dateStr,
                                  makeRoutines: makeRoutines)
         DayInfoDatabase.shared.saveDayInfoToDB(dayInfo: newDayInfo)
         return newDayInfo
      }
      return dayInfo
   }
   
   private func updateView() {
      guard let dayInfo = dayInfo else { return }
      if dayInfo.completion.routineNumber == 0 {
         completionRoutineLabel.text = Constants.freeDayStatus
         completionRoutineProgessBar.progress = 0
      } else {
         completionRoutineLabel.text = "\(dayInfo.completion.routineDone) / \(dayInfo.completion.routineNumber) thói quen được hoàn thành"
         completionRoutineProgessBar.progress = Float(dayInfo.completion.routineDone / dayInfo.completion.routineNumber)
      }
      emptyStateView.isHidden = !dayInfo.makeRoutines.isEmpty
      dateCollectionView.reloadData()
      routineTableView.reloadData()
   }
}

extension DiaryController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DiaryController.numberOfDates
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DateCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setDateForCell(date: dateNumber[indexPath.row],
                            weekDay: weekDays[indexPath.row] ?? "",
                            choose: indexPath.row == chooseDate ? true : false)
        return cell
    }
    
}

extension DiaryController: UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       dateLabel.text = indexPath.row != 12 ? DiaryController.dates[indexPath.row].getShortVNDateString() : "Hôm nay"
       chooseDate = indexPath.row
       dayInfo = getDayInfo(dateStr: dateString[indexPath.row])
       updateView()
   }
}

extension DiaryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayInfo?.makeRoutines.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let makeRoutine = dayInfo?.makeRoutines[indexPath.row] else {
            return UITableViewCell()
         }
         let cell: RoutineDiaryCelll = tableView.dequeueReusableCell(for: indexPath)
         cell.setContentForCell(makeRoutine: makeRoutine)
         return cell
    }

}

extension DiaryController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

extension DiaryController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.diary
}
