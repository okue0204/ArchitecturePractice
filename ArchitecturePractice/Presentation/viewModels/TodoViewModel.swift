
import Foundation
import SwiftUI
import Observation

@Observable
class TodoViewModel {
    
    private let useCase: TodoUseCase
    
    init(useCase: TodoUseCase) {
        self.useCase = useCase
    }
    
    var todos: [Todo] = []
    var swiftDataError: SwiftDataError = .saveFailed
    var hasError = false
    
    func save() throws {
        do {
            try useCase.save()
        } catch {
            swiftDataError = .saveFailed
            hasError = true
        }
    }
    
    func fetch() {
        do {
            todos = try useCase.fetch()
        } catch {
            swiftDataError = .fetchFailed
            hasError = true
        }
    }
    
    func addTodo(title: String, description: String) {
        do {
            try useCase.add(title: title, description: description)
            fetch()
        } catch {
            swiftDataError = .insertFailed
            hasError = true
        }
    }
    
    func update(todo: Todo, title: String, description: String) {
        do {
            if let index = todos.firstIndex(where: { $0.id == todo.id }) {
                let updateTodo = todos[index]
                updateTodo.title = title
                updateTodo.todoDescription = description 
                updateTodo.updatedAt = Date()
                try save()
            }
        } catch {
            swiftDataError = .updateFailed
            hasError = true
        }
    }
    
    func toggleComplete(todoId: UUID) {
        do {
            if let index = todos.firstIndex(where: { $0.id == todoId }) {
                let updateTodo = todos[index]
                updateTodo.isCompleted.toggle()
                try save()
            }
        } catch {
            swiftDataError = .updateFailed
            hasError = true
        }
    }
    
    func remove(todo: Todo) {
        do {
            try useCase.delete(todo: todo)
        } catch {
            swiftDataError = .deleteFailed
            hasError = true
        }
    }
}
