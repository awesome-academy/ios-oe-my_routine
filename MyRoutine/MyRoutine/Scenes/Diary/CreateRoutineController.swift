//
//  CreateRoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/16/19.
//  Copyright © 2019 huy. All rights reserved.
//

class CreateRoutineController: UIViewController {
    
    // MARK: - Variables
    let suggestIcon = ["⚽️", "🏃🏻‍♂️", "💪🏻", "📖", "🚴🏻‍♂️", "🏊🏻‍♂️"]
    let suggest = ["Đá bóng", "Chạy bộ", "Tập Gym", "Đọc sách", "Đạp xe", "Bơi lội"]
    let setting = ["Lặp lại", "Ngày bắt đầu", "Mục tiêu thực hiện", "Nhắc nhở", "Thời gian trong ngày"]
    let iconSetting = [ #imageLiteral(resourceName: "repeat"), #imageLiteral(resourceName: "calendar"), #imageLiteral(resourceName: "target"), #imageLiteral(resourceName: "remind"), #imageLiteral(resourceName: "time")]
    var state = ["Hàng ngày", "Hôm nay", "1 lần / ngày", "09:00", "Mọi lúc"]
    var repeatDay = [1, 2, 3, 4, 5, 6, 7]
    var repeatWeek = 1
    var routine =  RoutineModel(idRoutine: RoutineService.shared.getAllRoutine().count,
                                name: "NewRoutine",
                                dayStart: Date(),
                                target: TargetModel(type: 1, number: 1),
                                repeatRoutine: RepeatModel(type: 1,
                                                           value: [1, 2, 3, 4, 5, 6, 7]),
                                remind: [RemindModel(timeString: "9:00", state: true)],
                                period: 4,
                                doneCount: 0)
    
    // MARK: - Outlets
    @IBOutlet weak var collectionViewSuggest: UICollectionView!
    @IBOutlet weak var tableViewSetting: UITableView!
    @IBOutlet weak var tfNameRoutine: UITextField!

    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Setup
    func setUp() {
        tfNameRoutine.delegate = self
        tfNameRoutine.returnKeyType = .done
        setUpCollectionView()
        setUpTableView()
    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = collectionViewSuggest.witdh * 2/5
        let itemHeight = collectionViewSuggest.height
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .horizontal
        collectionViewSuggest.collectionViewLayout = layout
        collectionViewSuggest.dataSource = self
        collectionViewSuggest.delegate = self
        collectionViewSuggest.register(UINib(nibName: "CellSuggest", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    func setUpTableView() {
        tableViewSetting.dataSource = self
        tableViewSetting.delegate = self
        tableViewSetting.register(UINib(nibName: "CellSetUp", bundle: nil), forCellReuseIdentifier: "tbvcell")
    }
    
}

// MARK: - CollectionView
extension CreateRoutineController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CellSuggest else {
            return UICollectionViewCell()
        }
        cell.setUp(icon: suggestIcon[indexPath.row], suggest: suggest[indexPath.row])
        return cell
    }
    
}

extension CreateRoutineController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tfNameRoutine.text = suggest[indexPath.row]
    }
    
}

// MARK: - TableView
extension CreateRoutineController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tbvcell") as? CellSetUp else {
            return UITableViewCell()
        }
        cell.setUp(iconSetting: iconSetting[indexPath.row], setting: setting[indexPath.row], state: state[indexPath.row])
        return cell
    }
    
}

extension CreateRoutineController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height/13
    }
    
}

// MARK: - Textfi 
extension CreateRoutineController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
