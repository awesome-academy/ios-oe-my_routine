//
//  RepeatModel.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/16/19.
//  Copyright © 2019 huy. All rights reserved.
//

class RepeatModel: Object {
    
    // MARK: - Properties
    @objc dynamic var type = 0
    let value = List<Int>()
    convenience init(type: Int, value: [Int]) {
        self.init()
        self.type = type
        for i in value {
            self.value.append(i)
        }
    }
    
}
