//
//  ContentView.swift
//  ArchitecturePractice
//
//  Created by 奥江英隆 on 2025/11/20.
//

import SwiftUI

struct TodoListView: View {

    @State private var viewModel = TodoViewModel(useCase: TodoUseCase(repository: TodoRepositoryImpl()))
    @State private var editingTodo: Todo?
    @State private var isShowingAddSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.todos) { todo in
                    TodoRow(
                        todo: todo,
                        onToggleComplete: {
                            viewModel.toggleComplete(todoId: todo.id)
                        },
                        onEdit: {
                            editingTodo = todo
                        }
                    )
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let todo = viewModel.todos[index]
                        viewModel.remove(todo: todo)
                    }
                }
            }
            .onAppear(perform: {
                viewModel.fetch()
            })
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $editingTodo) { todo in
                TodoEditView(
                    todo: todo,
                    onSave: { title, description in
                        viewModel.update(todo: todo, title: title, description: description)
                        editingTodo = nil
                    },
                    onCancel: {
                        editingTodo = nil
                    }
                )
            }
            .sheet(isPresented: $isShowingAddSheet) {
                TodoAddView(
                    onSave: { title, description in
                        viewModel.addTodo(title: title, description: description)
                        isShowingAddSheet = false
                    },
                    onCancel: {
                        isShowingAddSheet = false
                    }
                )
            }
            .alert("エラー", isPresented: $viewModel.hasError) {
                Button(action: {
                    viewModel.hasError = false
                }) {
                    Text("OK")
                }
            } message: {
                Text(viewModel.swiftDataError.message)
            }
        }
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

                Text(todo.todoDescription)
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
