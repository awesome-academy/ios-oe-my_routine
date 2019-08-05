//
//  RoutineModelRealm.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/2/19.
//  Copyright © 2019 huy. All rights reserved.
//
import RealmSwift

class RealmString: Object {
    @objc dynamic var stringValue = ""
}

class RoutineModelRealm: Object {
    
    // MARK: - Properties
    @objc dynamic var idRoutine: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var dayStart: String = ""
    @objc dynamic var period: String = ""
    let repeatRou = List<RealmString>()
    let remindRou = List<RealmString>()
    var repeatRoutine: [String] {
        get {
            return repeatRou.map { $0.stringValue }
        }
        set {
            repeatRou.removeAll()
            repeatRou.append(objectsIn: newValue.map { RealmString(value: [$0]) })
        }
    }
    var remind: [String] {
        get {
            return remindRou.map { $0.stringValue }
        }
        set {
            remindRou.removeAll()
            remindRou.append(objectsIn: newValue.map { RealmString(value: [$0]) })
        }
    }
    
    // MARK: Method
    override static func ignoredProperties() -> [String] {
        return ["remind", "repeatRoutine"]
    }
    
}
