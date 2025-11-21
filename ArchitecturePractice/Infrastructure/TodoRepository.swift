//
//  TodoRepository.swift
//  ArchitecturePractice
//
//  Created by 奥江英隆 on 2025/11/21.
//

import Foundation
import SwiftData

protocol TodoRepository {
    func save() throws
    func insert(todo: Todo) throws
    func delete(todo: Todo) throws
    func fetch() throws -> [Todo]
}

class TodoRepositoryImpl: TodoRepository {
    
    let modelContainer: ModelContainer
    private var modelContext: ModelContext {
        modelContainer.mainContext
    }
    
    init() {
        let schema = Schema([Todo.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func save() throws {
        try modelContext.save()
    }
    
    func insert(todo: Todo) throws {
        modelContext.insert(todo)
        try save()
    }
    
    func delete(todo: Todo) throws {
        modelContext.delete(todo)
        try save()
    }
    
    func fetch() throws -> [Todo] {
        let fetchDescriptor = FetchDescriptor<Todo>()
        return try modelContext.fetch(fetchDescriptor)
    }
}

class TodoRepositoryMock: TodoRepository {
    func save() {}

    func insert(todo: Todo) {}

    func delete(todo: Todo) {}

    func fetch() -> [Todo] {
        [
            Todo(
                id: UUID(),
                title: "買い物",
                todoDescription: "牛乳とパンを買う",
                createdAt: Date(),
                updatedAt: Date(),
                isCompleted: false
            ),
            Todo(
                id: UUID(),
                title: "勉強",
                todoDescription: "SwiftUIを学習する",
                createdAt: Date(),
                updatedAt: Date(),
                isCompleted: true
            ),
            Todo(
                id: UUID(),
                title: "運動",
                todoDescription: "ジョギング30分",
                createdAt: Date(),
                updatedAt: Date(),
                isCompleted: false
            )
        ]
    }
}
