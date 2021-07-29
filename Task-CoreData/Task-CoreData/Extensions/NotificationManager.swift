//
//  NotificationManager.swift
//  Task-CoreData
//
//  Created by Bryan Gomez on 7/28/21.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject {
    static let shared = NotificationManager()
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { authorize, error in
            if authorize {
                UNUserNotificationCenter.current().delegate = self
                self.setNotificationCategories()
            } else  {
                if let error = error {
                    print("\(error)")
                }
                
            }
        }
    }
    
    func setNotificationCategories() {
        // create actions
        let markCompletedAction = UNNotificationAction(identifier: Constants.markCompleteNotificationActionIdentifier, title: Constants.complete, options: UNNotificationActionOptions(rawValue: 0))
        let ignoreAction = UNNotificationAction(identifier: Constants.ignoreNotificationActionIdentifier, title: Constants.ignore, options: UNNotificationActionOptions(rawValue: 0))
        
        // create category with actions.
        let taskActionsCategory = UNNotificationCategory(identifier: Constants.notificationCategoryIdentifier, actions: [markCompletedAction, ignoreAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
        
        // set the category
        UNUserNotificationCenter.current().setNotificationCategories([taskActionsCategory])
        
        
    }
    
}
//MARK: - Notification Delegate

extension NotificationManager: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        NotificationCenter.default.post(name: Notification.Name(Constants.reminderReceivedNotificationName), object: nil)
        completionHandler([.sound, .banner])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == Constants.markCompleteNotificationActionIdentifier,
           let taskID = response.notification.request.content.userInfo[Constants.taskID]  as? String { // getting dictionary id as a string
            print("Marked as completed. \(taskID)")
            completionHandler()
            
    }
}
    
    // presenting notifiction
    
}
