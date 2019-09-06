//
//  String+.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/2/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension String {
    
    var int: Int {
        return Int(self) ?? -1
    }
    
    func getDate(format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format 
        return formatter.date(from: self) ?? Date()
    }
}
