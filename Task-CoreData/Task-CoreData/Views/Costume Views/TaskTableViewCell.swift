//
//  TaskTableViewCell.swift
//  Task-CoreData
//
//  Created by Bryan Gomez on 7/27/21.
//

import UIKit
protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    
    weak var delegate: TaskCompletionDelegate?
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func completionButtonTapped(_ sender: UIButton) {
        delegate?.taskCellButtonTapped(self)
    }
    
    func updateViews() {
        
        guard let task = task else { return }
        taskNameLabel.text = task.name
        dueDateLabel.text = task.dueDate?.dateAsString()
        
        let image = task.isComplete ? UIImage(named: "complete") : UIImage(named: "incomplete")
        completionButton.setImage(image, for: .normal)
    }
    
    
 
}
