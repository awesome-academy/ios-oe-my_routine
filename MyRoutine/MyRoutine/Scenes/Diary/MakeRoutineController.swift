//
//  MakeRoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/23/19.
//  Copyright © 2019 huy. All rights reserved.
//

import MBCircularProgressBar

final class MakeRoutineController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var routineNameLabel: UILabel!
    @IBOutlet private weak var maxValueLabel: UILabel!
    @IBOutlet private weak var progessBarView: MBCircularProgressBarView!
    
    // MARK: - Variables
    let durationLowSpeed = 0.2
    let durationHighSpeed = 0.4
    var makeRoutine = MakeRoutine(routine: RoutineModel.defautInit(),
                                  completion: CompletionModel(targetTime: 0, doneCount: 0))
    var dateStr = Date().getShortVNDateString()
  
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProgessBar()
        setUpView()
    }
    
    // MARK: - Setup
    private func setUpView() {
        routineNameLabel.text = makeRoutine.routine.nameRoutine
        dateLabel.text = dateStr
    }
    
    private func setUpProgessBar() {
        maxValueLabel.text = "\(Int(makeRoutine.completion.targetTime))"
        progessBarView.maxValue = CGFloat(makeRoutine.completion.targetTime)
        progessBarView.value = CGFloat(makeRoutine.completion.doneCount)
    }
    
    // MARK: - Support Method
    private func updateCountIntoView(duration: Double, value: Float) {
        UIView.animate(withDuration: duration) {
            self.progessBarView.value = CGFloat(value)
        }
    }
    
    // MARK: - Actions
    @IBAction func handleAddButton(_ sender: Any) {
        if makeRoutine.completion.increseDoneCount(add: 1) {
             updateCountIntoView(duration: durationLowSpeed, value: makeRoutine.completion.doneCount)
        }
    }
    
    @IBAction func hanldeSubtractButton(_ sender: Any) {
        if makeRoutine.completion.increseDoneCount(add: -1) {
            updateCountIntoView(duration: durationLowSpeed, value: makeRoutine.completion.doneCount)
        }
    }
    
    @IBAction func handleFinishButton(_ sender: Any) {
        makeRoutine.completion.doneCount = makeRoutine.completion.targetTime
        updateCountIntoView(duration: durationHighSpeed, value: makeRoutine.completion.doneCount)
    }
    
    @IBAction func handleUndoButton(_ sender: Any) {
        makeRoutine.completion.doneCount = 0
        updateCountIntoView(duration: durationHighSpeed, value: makeRoutine.completion.doneCount)
    }
    
    @IBAction func handleBackButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateMakeRoutine"),
                                        object: nil,
                                        userInfo: ["message": makeRoutine])
        navigationController?.popViewController(animated: true)
    }
}

extension MakeRoutineController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.diary
}
