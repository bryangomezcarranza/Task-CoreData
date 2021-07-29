//
//  TaskScheduler.swift
//  Task-CoreData
//
//  Created by Bryan Gomez on 7/28/21.
//

import Foundation
import UserNotifications

class TaskScheduler {
    func clearNotifications(for task: Task) {
        guard let identifier = task.id?.uuidString else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    func scheduleNotification(for task: Task) {
        guard let timeStamp = task.dueDate, let identifier = task.id?.uuidString else { return }
        clearNotifications(for: task)
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "To do task \(task.name ?? "Task")"
        content.sound = .default
        content.userInfo = [Constants.taskID : identifier]
        content.categoryIdentifier = Constants.taskReminderCategoryIdentifier
        
        let fireDateComponent = Calendar.current.dateComponents([.hour, .minute], from: timeStamp)
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponent, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        //call it
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Unable to add notification request. Error \(error.localizedDescription)")
            }
        }
    }
}
