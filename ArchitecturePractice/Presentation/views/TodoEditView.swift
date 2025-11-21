//
//  TodoEditView.swift
//  ArchitecturePractice
//
//  Created by 奥江英隆 on 2025/11/21.
//

import SwiftUI

struct TodoEditView: View {
    let todo: Todo
    let onSave: (String, String) -> Void
    let onCancel: () -> Void

    @State private var title: String
    @State private var description: String

    init(todo: Todo, onSave: @escaping (String, String) -> Void, onCancel: @escaping () -> Void) {
        self.todo = todo
        self.onSave = onSave
        self.onCancel = onCancel
        _title = State(initialValue: todo.title)
        _description = State(initialValue: todo.todoDescription)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("タイトル")) {
                    TextField("タイトルを入力", text: $title)
                }

                Section(header: Text("説明")) {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Todoを編集")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        onCancel()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("保存") {
                        onSave(title, description)
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    TodoEditView(
        todo: Todo(id: UUID(),
                   title: "サンプル",
                   todoDescription: "説明文",
                   createdAt: Date(),
                   updatedAt: Date(),
                   isCompleted: false),
        onSave: { _, _ in },
        onCancel: {}
    )
}
