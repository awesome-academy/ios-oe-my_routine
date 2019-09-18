//
//  NotificationService.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 9/18/19.
//  Copyright © 2019 huy. All rights reserved.
//

import UserNotifications

class NotificationSerivce {
    
    // MARK: - Singleton
    static let shared = NotificationSerivce()
    
    // MARK: - Support Method
    func registerPushNotification(application: UIApplication = UIApplication.shared,
                                  completion: (() -> Void)? = nil) {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { settings in
            guard settings.authorizationStatus == .notDetermined else { return }
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in
                DispatchQueue.main.async { completion?() }
            })
        })
        application.registerForRemoteNotifications()
    }
    
    func removeAllLocalNotifications(completion: @escaping (() -> Void)) {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            DispatchQueue.main.async {
                let removeIds = requests.map({ $0.identifier })
                center.removePendingNotificationRequests(withIdentifiers: removeIds)
                print("[Local Notification] Removed all !")
                completion()
            }
        })
    }
    
    func addNotificationARoutine(routine: RoutineModel) {
        let name = routine.nameRoutine
        let remindTime = RoutineDatabase.shared.getTimeRemind(routine: routine)
        var allDateComponents = [DateComponents]()
        for time in remindTime {
            for weekDay in routine.repeatRoutine {
                var dateComponents = DateComponents()
                dateComponents.hour = time.hour
                dateComponents.minute = time.minute
                dateComponents.weekday = weekDay.value
                allDateComponents.append(dateComponents)
            }
        }
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent().then {
            $0.title = name
            $0.body = Constants.notificationBody
        }
        for dateComponents in allDateComponents {
            let identifier = "\(routine.nameRoutine)\(dateComponents.weekday ?? 0)"
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                        repeats: true)
            let request = UNNotificationRequest(identifier: identifier,
                                                content: content,
                                                trigger: trigger)
            center.add(request) { error in
                if let error = error {
                    print("Error \(error)")
                }
            }
        }
    }
    
    func refreshLocalNotifications(completion: (() -> Void)? = nil) {
        removeAllLocalNotifications {
            RoutineDatabase.shared.getAllRoutine().map {
                self.addNotificationARoutine(routine: $0)
            }
            completion?()
        }
    }

}
