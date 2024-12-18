//
//  PermissionHelper.swift
//  SelfUI
//
//  Created by Long Pham on 11/12/24.
//

import UserNotifications

struct PermissionHelper {
    static func requestNotificationPermission(completion: ((Bool) -> Void)? = nil) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Error requesting notification permission: \(granted) - \(error?.localizedDescription)")
            DispatchQueue.main.async {
                completion?(granted)
            }
        }
    }
}
