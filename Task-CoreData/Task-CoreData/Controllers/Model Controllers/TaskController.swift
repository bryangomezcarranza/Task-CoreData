//
//  TaskController.swift
//  Task-CoreData
//
//  Created by Bryan Gomez on 7/27/21.
//

import Foundation
import CoreData

class TaskController {
    static let shared = TaskController()
    let notificationScheduler = TaskScheduler()
    
    var tasks: [Task] = []
    
    // Fetch Request Set.
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task") // looking for a Medication
        request.predicate = NSPredicate(value: true) // true will fetch anything of type Medication.
        return request
    }()
    private init() {}
    
//MARK: - CRUD
    func createTaskWith( name: String, notes: String?, dueDate: Date?) {
       let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        CoreDataStack.saveContext()
        
        notificationScheduler.scheduleNotification(for: newTask)
    }
    func fetchTasks() {
        let task = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        self.tasks = task
    }
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContext()
        
        if !task.isComplete {
            notificationScheduler.scheduleNotification(for: task)
        }
    }
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        CoreDataStack.saveContext()
        
        if task.isComplete {
            notificationScheduler.clearNotifications(for: task)
        }
        
    }
    func delete(task: Task) {
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContext()
        fetchTasks() // load data again. 
    }
}
