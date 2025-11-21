
import Foundation

class TodoUseCase {
    
    private let repository: TodoRepository
    
    init(repository: TodoRepository) {
        self.repository = repository
    }
    
    func save() throws {
        try repository.save()
    }
    
    func fetch() throws -> [Todo] {
        try repository.fetch()
    }
    
    func add(title: String, description: String) throws {
        let newTodo = Todo(
            id: UUID(),
            title: title,
            todoDescription: description,
            createdAt: Date(),
            updatedAt: Date(),
            isCompleted: false
        )
        try repository.insert(todo: newTodo)
    }
    
    func delete(todo: Todo) throws {
        try repository.delete(todo: todo)
    }
}
