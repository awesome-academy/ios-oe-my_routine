//
//  NoteRoutineController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/17/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class NoteRoutineController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var heightOfTextView: NSLayoutConstraint!
    @IBOutlet private weak var noteTextView: UITextView!
    
    // MARK: - Variables
    var routine: RoutineModel?
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Support Method
    func setUp() {
        noteTextView.do {
            $0.text = routine?.noteRoutine ?? ""
            $0.delegate = self
            textViewDidChange($0)
        }
    }
}

extension NoteRoutineController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: SystemInfo.screenWidth,
                          height: .infinity)
        let estimateSize = textView.sizeThatFits(size)
        heightOfTextView.constant = estimateSize.height
        routine?.noteRoutine = textView.text
    }
}

extension NoteRoutineController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.statisticARoutine
}
