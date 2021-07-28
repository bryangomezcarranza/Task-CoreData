//
//  TaskListTableViewController.swift
//  Task-CoreData
//
//  Created by Bryan Gomez on 7/27/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TaskController.shared.fetchTasks() // loads data back from persistance store.
        tableView.reloadData() // reloads data once back to view.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return TaskController.shared.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell()}
        let task = TaskController.shared.tasks[indexPath.row]
        cell.task = task
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.delete(task: task)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? TaskDetailViewController else { return }
            let taskToSend = TaskController.shared.tasks[indexPath.row]
            destinationVC.task = taskToSend
        }
    }
}

//MARK: - TaskCompletionDelegate
extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        // need index path from sender to see what cell they tapped on. 
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.tasks[indexPath.row]
        TaskController.shared.toggleIsComplete(task: task)
        sender.updateViews()
    }
    
    
}
