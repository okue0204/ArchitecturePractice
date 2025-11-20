//
//  ContentView.swift
//  ArchitecturePractice
//
//  Created by 奥江英隆 on 2025/11/20.
//

import SwiftUI

struct TodoListView: View {
    // モックデータ
    @State private var todos: [Todo] = [
        Todo(id: UUID(), title: "買い物", description: "牛乳とパンを買う", createdAt: Date(), updatedAt: Date(), isCompleted: false),
        Todo(id: UUID(), title: "勉強", description: "SwiftUIを学習する", createdAt: Date(), updatedAt: Date(), isCompleted: true),
        Todo(id: UUID(), title: "運動", description: "ジョギング30分", createdAt: Date(), updatedAt: Date(), isCompleted: false)
    ]

    @State private var editingTodo: Todo?
    @State private var isShowingEditSheet = false
    @State private var isShowingAddSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    TodoRow(
                        todo: todo,
                        onToggleComplete: {
                            toggleComplete(id: todo.id)
                        },
                        onEdit: {
                            editingTodo = todo
                            isShowingEditSheet = true
                        }
                    )
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingEditSheet) {
                if let todo = editingTodo {
                    TodoEditView(
                        todo: todo,
                        onSave: { title, description in
                            updateTodo(id: todo.id, title: title, description: description)
                            isShowingEditSheet = false
                        },
                        onCancel: {
                            isShowingEditSheet = false
                        }
                    )
                }
            }
            .sheet(isPresented: $isShowingAddSheet) {
                TodoAddView(
                    onSave: { title, description in
                        addTodo(title: title, description: description)
                        isShowingAddSheet = false
                    },
                    onCancel: {
                        isShowingAddSheet = false
                    }
                )
            }
        }
    }

    private func toggleComplete(id: UUID) {
        if let index = todos.firstIndex(where: { $0.id == id }) {
            let todo = todos[index]
            let updatedTodo = Todo(
                id: todo.id,
                title: todo.title,
                description: todo.description,
                createdAt: todo.createdAt,
                updatedAt: Date(),
                isCompleted: !todo.isCompleted
            )
            todos[index] = updatedTodo
        }
    }

    private func updateTodo(id: UUID, title: String, description: String) {
        if let index = todos.firstIndex(where: { $0.id == id }) {
            let todo = todos[index]
            let updatedTodo = Todo(
                id: todo.id,
                title: title,
                description: description,
                createdAt: todo.createdAt,
                updatedAt: Date(),
                isCompleted: todo.isCompleted
            )
            todos[index] = updatedTodo
        }
    }

    private func addTodo(title: String, description: String) {
        let newTodo = Todo(
            id: UUID(),
            title: title,
            description: description,
            createdAt: Date(),
            updatedAt: Date(),
            isCompleted: false
        )
        todos.append(newTodo)
    }
}

struct TodoRow: View {
    let todo: Todo
    let onToggleComplete: () -> Void
    let onEdit: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button {
                onToggleComplete()
            } label: {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(todo.isCompleted ? .green : .gray)
                    .font(.title2)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(todo.title)
                    .font(.headline)
                    .strikethrough(todo.isCompleted)
                    .foregroundStyle(todo.isCompleted ? .secondary : .primary)

                Text(todo.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                Text(todo.createdAt, style: .date)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture {
                onEdit()
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TodoListView()
}
