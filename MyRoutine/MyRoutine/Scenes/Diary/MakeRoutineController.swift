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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProgessBar()
    }
    
    // MARK: - Variables
    var maxValue: CGFloat = 10
    var doneCount: CGFloat = 0
    
    // MARK: - Setup
    func setUpProgessBar() {
        maxValueLabel.text = "\(Int(maxValue))"
        progessBarView.maxValue = maxValue
        progessBarView.value = doneCount
    }
    
    // MARK: - Actions
    @IBAction func handleAddButton(_ sender: Any) {
        if doneCount < maxValue {
            doneCount += 1
            UIView.animate(withDuration: 0.2) {
                self.progessBarView.value += 1
            }
        }
    }
    
    @IBAction func hanldeSubtractButton(_ sender: Any) {
        if doneCount > 0 {
            doneCount -= 1
            UIView.animate(withDuration: 0.2) {
                self.progessBarView.value -= 1
            }
        }
    }
    
    @IBAction func handleFinishButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.progessBarView.value = self.maxValue
        }
    }
    
    @IBAction func handleUndoButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.progessBarView.value =  0
        }
    }
}
