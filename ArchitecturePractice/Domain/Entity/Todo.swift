//
//  Todo.swift
//  ArchitecturePractice
//
//  Created by 奥江英隆 on 2025/11/21.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Todo: Identifiable, Equatable {
    var id: UUID
    var title: String
    var todoDescription: String
    var createdAt: Date
    var updatedAt: Date
    var isCompleted: Bool
    
    init(id: UUID, title: String, todoDescription: String, createdAt: Date, updatedAt: Date, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.todoDescription = todoDescription
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isCompleted = isCompleted
    }
}
