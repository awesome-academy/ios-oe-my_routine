//
//  DiaryController.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/1/19.
//  Copyright © 2019 huy. All rights reserved.
//

class DiaryController: UIViewController {
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func btnCreat(_ sender: Any) {
        let controller = Storyboards.diary.instantiateViewController(withIdentifier: "Nav")
        self.present(controller, animated: true, completion: nil)
        
    }
    
}
