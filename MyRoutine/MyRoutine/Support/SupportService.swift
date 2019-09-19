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
        if array.count < 2 { return 1 }
        var longest = 1
        var currentCount = 1
        for i in 0...(array.count - 2) {
            if array[i] + 1 == array[i + 1] {
                currentCount += 1
            } else {
                longest = max(longest, currentCount)
                currentCount = 1
            }
        }
        longest = max(longest, currentCount)
        return longest
    }
    
}
