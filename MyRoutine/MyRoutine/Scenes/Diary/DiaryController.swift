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
   private var dayInfoShow: DayInfo?
    private var dayInfo: DayInfo?
    private var routine = [RoutineModel]()
    private var chooseDate = DiaryController.numberOfDates - 2
    private var indexRoutine = 0
    private let dateNumber = DiaryController.dates.map {
        $0.getStrDateFormat(format: "dd")
    }
    private let weekDays = DiaryController.dates.map {
        DayOfWeek(rawValue: $0.weekday)?.shortTitle
    }
    private let dateString = DiaryController.dates.map {
        $0.getFullDateString()
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var dateCollectionView: UICollectionView!
    @IBOutlet private weak var routineTableView: UITableView!
    @IBOutlet private weak var emptyStateView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var completionRoutineProgessBar: UIProgressView!
    @IBOutlet private weak var completionRoutineLabel: UILabel!
   
    // MARK: - Denit
    deinit {
       NotificationCenter.default.removeObserver(self)
    }
   
   // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        dayInfo = getDayInfo(dateStr: dateString[DiaryController.numberOfDates - 2])
        setUpCollectionView()
        setUpTableView()
        updateView()
        receiveNotification()
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
            $0.modalPresentationStyle = .fullScreen
        }
      
        self.present(controller, animated: true, completion: nil)
    }
   
   @IBAction func handleFIlterInfo(_ sender: Any) {
      let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      let addToShowMorningRoutine = UIAlertAction(title: "Sáng", style: .default) { _ in
      }
      let addToShowNoonRoutine = UIAlertAction(title: "Trưa", style: .default) { _ in
      }
      let addToShowAfternoonRoutine = UIAlertAction(title: "Chiều", style: .default) { _ in
      }
      let addToShowNightRoutine = UIAlertAction(title: "Tối", style: .default) { _ in
      }
      let cancle = UIAlertAction(title: "Huỷ", style: .cancel)
      optionMenu.do {
         $0.addAction(addToShowMorningRoutine)
         $0.addAction(addToShowNoonRoutine)
         $0.addAction(addToShowAfternoonRoutine)
         $0.addAction(addToShowNightRoutine)
         $0.addAction(cancle)
      }
      present(optionMenu, animated: true, completion: nil)
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
   
   private func routineForDay(routine: RoutineModel, dateStr: String) -> Bool {
      let date = dateStr.getDate(format: DateFormat.fullDateFormat.rawValue)
      if routine.dayStart.getDate(format: DateFormat.fullDateFormat.rawValue) <= date {
         for day in routine.repeatRoutine where day.value == date.weekday {
            return true
         }
      }
      return false
   }
   
   private func getRoutineForDay(dateStr: String) -> [RoutineModel] {
      var routines = [RoutineModel]()
      for rou in RoutineDatabase.shared.getAllRoutine() {
         if routineForDay(routine: rou, dateStr: dateStr) {
            routines.append(rou)
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
         completionRoutineProgessBar.progress = Float(dayInfo.completion.routineDone) / Float(dayInfo.completion.routineNumber)
      }
      emptyStateView.isHidden = !dayInfo.makeRoutines.isEmpty
      dateCollectionView.reloadData()
      routineTableView.reloadData()
   }
   
   private func receiveNotification() {
      NotificationCenter.default.addObserver(self,
                                             selector: #selector(updateMakeRoutine(notification:)),
                                             name: NSNotification.Name(rawValue: "updateMakeRoutine"),
                                             object: nil)
      NotificationCenter.default.addObserver(self,
                                             selector: #selector(updateDayInfo(notification:)),
                                             name: NSNotification.Name(rawValue: "updateDayInfo"),
                                             object: nil)
   }
   
   @objc func updateMakeRoutine(notification: Notification) {
      guard let mess = notification.userInfo,
         let msg = mess["message"],
         let makeRoutines = MapperService.shared.convertAnyToObject(any: msg, typeOpject: MakeRoutine.self),
         let dayIf = dayInfo else { return }
      var updateNewDayInfo = dayIf
      updateNewDayInfo.makeRoutines[indexRoutine] = makeRoutines
      DayInfoDatabase.shared.updateDayInfo(dateStr: dayIf.date,
                                           updateDayInfo: updateNewDayInfo) {[weak self] newDayInfo in
         self?.dayInfo = newDayInfo
         self?.updateView()
      }
   }
   
   @objc func updateDayInfo(notification: Notification) {
      guard let mess = notification.userInfo,
         let msg = mess["message"],
         let routine = MapperService.shared.convertAnyToObject(any: msg, typeOpject: RoutineModel.self) else { return }
      for dayInfo in DayInfoDatabase.shared.getAllDayInfo() {
         if routineForDay(routine: routine, dateStr: dayInfo.date) {
            var newDayIf = dayInfo
            let completion = CompletionModel(targetTime: Float(routine.targetRoutine),
                                             doneCount: 0)
            let makeRoutine = MakeRoutine(routine: routine,
                                          completion: completion)
            newDayIf.makeRoutines.append(makeRoutine)
            DayInfoDatabase.shared.updateDayInfo(dateStr: dayInfo.date,
                                                 updateDayInfo: newDayIf)
         }
      }
      dayInfo = getDayInfo(dateStr: dateString[chooseDate])
      updateView()
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
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let makeRoutine = dayInfo?.makeRoutines[indexPath.row] else { return }
        indexRoutine = indexPath.row
        let controller = MakeRoutineController.instantiate().then {
            $0.dateStr = DiaryController.dates[chooseDate].getShortVNDateString()
            $0.makeRoutine = makeRoutine
        }
        navigationController?.pushViewController(controller, animated: true)
    }
   
}

extension DiaryController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.diary
}
