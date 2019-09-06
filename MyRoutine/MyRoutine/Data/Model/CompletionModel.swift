//
//  CompletionModel.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/26/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct CompletionModel {
    var targetTime: Float
    var doneCount: Float
    var currentProgess: Float {
        return Float(doneCount / targetTime)
    }
    
    mutating func increseDoneCount(add number: Float) -> Bool {
        if (number > 0 && doneCount < targetTime) || (number < 0 && doneCount > 0) {
            self.doneCount += number
            return true
        }
        return false
    }
}
