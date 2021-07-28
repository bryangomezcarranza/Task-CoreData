//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by Bryan Gomez on 7/27/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    var task: Task?
    var date: Date? // used to capture users selected due date.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
   
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = taskNameTextField.text, !name.isEmpty, let note = taskNotesTextView.text, !note.isEmpty else { return }
        let date = taskDueDatePicker.date
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: note, dueDate: date)
        } else {
            TaskController.shared.createTaskWith(name: name, notes: note, dueDate: date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        guard let date = date else { return }
        taskDueDatePicker.date = date
    }
    
    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
    }
    
  
}
