//
//  DiaryController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/1/19.
//  Copyright © 2019 huy. All rights reserved.
//

class DiaryController: UIViewController {
    
    // MARK: - View Life
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func handleButtonCreate(_ sender: Any) {
        let controller = UINavigationController()
        controller.navigationBar.isHidden = true
        controller.viewControllers = [CreateRoutineController.instantiate()]
        self.present(controller, animated: true, completion: nil)
    }
    
}

extension DiaryController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.diary
}
