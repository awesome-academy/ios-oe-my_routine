//
//  PasswordInputContrroller.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/18/19.
//  Copyright © 2019 huy. All rights reserved.
//

enum TypeInputPasscode {
    case comfirmNewPasscode
    case failToComfirmNewPasscode
    case inputPasscode
    case newPasscode
}

final class PasswordInputContrroller: UIViewController {
    
    // MARK: - Constants
    struct Constants {
        static let defaultCheckInput = Array.init(repeating: false, count: 4)
        static let inputPasscodeStr = "Nhập mật khẩu"
        static let createNewPasscodeStr = "Nhập mật khẩu mới"
        static let comfirmNewPasscodeStr = "Nhập lại mật khẩu"
        static let failToConfirmNewPasscodeStr = "Mật khẩu xác nhận chưa đúng"
        static let numberOfPasscodeNumber = 4
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var typePasswordLabel: UILabel!
    @IBOutlet private weak var collectionViewPw: UICollectionView!
    
    // MARK: - Variables
    var inputString = ""
    var checkInput = Constants.defaultCheckInput
    var typeOfInputPasscode = TypeInputPasscode.newPasscode
    var newPasscode = ""
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    // MARK: - Actions
    @IBAction func handleDeleteButton(_ sender: Any) {
        if !inputString.isEmpty {
            checkInput[inputString.count - 1] = false
            inputString.removeLast()
            collectionViewPw.reloadData()
        }
    }
    
    @IBAction func handleNumberButton(_ sender: RoundedButton) {
        inputString += sender.titleLabel?.text ?? ""
        checkInput[inputString.count - 1] = true
        collectionViewPw.reloadData()
        if inputString.count == 4 {
            checkInput(passInput: inputString)
        }
    }
    
    // MARK: - Setup
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout().then {
            let itemWidth = collectionViewPw.witdh / 4
            let itemHeight = collectionViewPw.height
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
            $0.itemSize = CGSize(width: itemWidth, height: itemHeight)
            $0.scrollDirection = .horizontal
        }
        collectionViewPw.do {
            $0.collectionViewLayout = layout
            $0.dataSource = self
            $0.register(cellType: InputPasscodeCell.self)
        }
    }
    
    // MARK: - Support Method
    func checkInput(passInput: String) {
        switch typeOfInputPasscode {
        case .newPasscode:
            newPasscode = inputString
            setToDefault()
            typePasswordLabel.text = Constants.comfirmNewPasscodeStr
            typeOfInputPasscode = .comfirmNewPasscode
            
        case .comfirmNewPasscode:
            if inputString == newPasscode {
                PasscodeService.shared.addNewPasscode(newPasscode: newPasscode)
                navigationController?.popViewController(animated: true)
            } else {
                typePasswordLabel.text = Constants.failToConfirmNewPasscodeStr
                setToDefault()
                typeOfInputPasscode = .failToComfirmNewPasscode
            }
            
        case .failToComfirmNewPasscode:
            if inputString == newPasscode {
                navigationController?.popViewController(animated: true)
            } else {
                setToDefault()
            }
            
        case .inputPasscode:
            if PasscodeService.shared.checkRightPasscode(inputPasscode: inputString) {
                self.dismiss(animated: true, completion: nil)
            } else {
                setToDefault()
            }
        }
        collectionViewPw.reloadData()
    }
    
    func setToDefault() {
        inputString = ""
        checkInput = Constants.defaultCheckInput
    }
    
}

extension PasswordInputContrroller: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.numberOfPasscodeNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:  InputPasscodeCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setUp(inputed: checkInput[indexPath.row])
        return cell
    }
}

extension PasswordInputContrroller: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.setting
}
