//
//  TargetModel.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/16/19.
//  Copyright © 2019 huy. All rights reserved.
//

class TargetModel: Object {
    
    // MARK: - Properties
    @objc dynamic var type = 0
    @objc dynamic var number = 1
    convenience init(type: Int, number: Int) {
        self.init()
        self.type = type
        self.number = number
    }

}
