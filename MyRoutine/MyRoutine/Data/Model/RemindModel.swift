//
//  RemindModel.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/16/19.
//  Copyright © 2019 huy. All rights reserved.
//

class RemindModel: Object {
    
    // MARK: - Properties
    @objc dynamic var timeString = "09:00"
    @objc dynamic var state = true
    convenience init(timeString: String, state: Bool) {
        self.init()
        self.timeString = timeString
        self.state = state
    }
    
}
