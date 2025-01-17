//
//  DateFormatter.swift
//  Task-CoreData
//
//  Created by Bryan Gomez on 7/27/21.
//

import Foundation

extension Date {
    func dateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
