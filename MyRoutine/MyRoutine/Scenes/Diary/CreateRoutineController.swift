//
//  CreateRoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/16/19.
//  Copyright © 2019 huy. All rights reserved.
//

class CreateRoutineController: UIViewController {
    
    // MARK: - Variables
    var state = Constants.defaultNewRoutine
    var repeatDay = Constants.allWeek
    var repeatWeek = 1
    var routine =  RoutineModel.defautInit()
    
    // MARK: - Outlets
    @IBOutlet weak var suggestCollectionView: UICollectionView!
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var nameRoutineTf: UITextField!

    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Setup
    func setUp() {
        nameRoutineTf.delegate = self
        nameRoutineTf.returnKeyType = .done
        setUpCollectionView()
        setUpTableView()
    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = suggestCollectionView.witdh * 2 / 5
        let itemHeight = suggestCollectionView.height
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .horizontal
        suggestCollectionView.collectionViewLayout = layout
        suggestCollectionView.dataSource = self
        suggestCollectionView.delegate = self
        suggestCollectionView.register(cellType: SuggestionViewCell.self)
    }
    
    func setUpTableView() {
        settingTableView.dataSource = self
        settingTableView.delegate = self
        settingTableView.register(cellType: RoutineComponentCell.self)
    }
    
}

// MARK: - CollectionView
extension CreateRoutineController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.suggestNameRoutine.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SuggestionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setUp(icon: Constants.suggestIcon[indexPath.row],
                   suggest: Constants.suggestNameRoutine[indexPath.row])
        return cell
    }
}

extension CreateRoutineController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nameRoutineTf.text = Constants.suggestNameRoutine[indexPath.row]
    }
}

// MARK: - TableView
extension CreateRoutineController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.defaultComponents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RoutineComponentCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setUp(iconSetting: Constants.iconCategory[indexPath.row],
                   setting: Constants.defaultComponents[indexPath.row],
                   state: state[indexPath.row])
        return cell
    }
}

extension CreateRoutineController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height / 13
    }
}

// MARK: - Textfield
extension CreateRoutineController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateRoutineController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.diary
}
