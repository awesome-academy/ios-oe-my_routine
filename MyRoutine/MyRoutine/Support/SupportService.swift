//
//  SupportService.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

class SupportService {
    
    static let shared = SupportService()
    
    /// This function returns maximum number of consecutive number in a Int Array
    ///
    /// Usage:
    ///     let arrayInt = [1, 2, 3, 5, 6, 8, 9, 10]
    ///     println(maximalConsecutiveNumber(in: arrayInt) // 3 -> [1, 2, 3]
    ///
    /// - Parameter array of Int
    ///
    func maximalConsecutiveNumbers(in array: [Int]) -> Int {
        if array.count == 1 { return 1 }
        var longest = 0
        var current = 1
        for (prev, next) in zip(array, array.dropFirst()) {
            if next > prev + 1 {
                current = 1
            } else if next == prev + 1 {
                current += 1
            }
            if current > longest {
                longest = current
            }
        }
        return longest
    }
    
}
