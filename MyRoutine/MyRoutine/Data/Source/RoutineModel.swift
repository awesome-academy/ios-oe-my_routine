//
//  RoutineModel.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/2/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct RoutineModel {
    
    // MARK: - Properties
    var idRoutine: Int
    var name: String
    var dayStart: String
    var repeatRoutine: [Int]
    var remind: [String]
    var period: Int
    
    // MARK: - Init
    init(idRoutine: Int, name: String, dayStart: String,
         repeatRoutine: [Int], remind: [String], period: Int) {
        self.idRoutine = idRoutine
        self.name = name
        self.dayStart = dayStart
        self.repeatRoutine = repeatRoutine
        self.remind = remind
        self.period = period
    }
    
    init(idRoutine: String, name: String, dayStart: String,
         repeatRoutine: [String], remind: [String], period: String) {
        self.idRoutine = idRoutine.int
        self.name = name
        self.dayStart = dayStart
        var temp = [Int]()
        temp.append(contentsOf: repeatRoutine.map { $0.int })
        self.repeatRoutine = temp
        self.remind = remind
        self.period = period.int
    }
    
}
