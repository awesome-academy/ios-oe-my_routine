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
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var progessBarView: MBCircularProgressBarView!
    
    // MARK: - Variables
    
    let durationLowSpeed = 0.1
    let durationHighSpeed = 0.4
    var completion = CompletionModel(targetTime: 10, doneCount: 0)
    var maxValue: CGFloat = 10
    var doneCount: CGFloat = 0
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProgessBar(completionModel: completion)
    }
    
    // MARK: - Setup
    func setUpProgessBar(completionModel: CompletionModel) {
        maxValueLabel.text = "\(Int(completionModel.targetTime))"
        progessBarView.maxValue = CGFloat(completionModel.targetTime)
        progessBarView.value = CGFloat(completionModel.doneCount)
    }
    
    // MARK: - Support Method
    func updateCountIntoView(duration: Double, value: Float) {
        UIView.animate(withDuration: duration) {
            self.progessBarView.value = CGFloat(value)
        }
    }
    
    // MARK: - Actions
    @IBAction func handleAddButton(_ sender: Any) {
        if completion.increseDoneCount(add: 1) {
             updateCountIntoView(duration: durationLowSpeed, value: completion.doneCount)
        }
    }
    
    @IBAction func hanldeSubtractButton(_ sender: Any) {
        if completion.increseDoneCount(add: -1) {
            updateCountIntoView(duration: durationLowSpeed, value: completion.doneCount)
        }
    }
    
    @IBAction func handleFinishButton(_ sender: Any) {
        completion.doneCount = completion.targetTime
        updateCountIntoView(duration: durationHighSpeed, value: completion.doneCount)
    }
    
    @IBAction func handleUndoButton(_ sender: Any) {
        completion.doneCount = 0
        updateCountIntoView(duration: durationHighSpeed, value: completion.doneCount)
    }
}
