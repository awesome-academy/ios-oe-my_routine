//
//  List+.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/12/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension List {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
