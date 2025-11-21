//
//  TodoAddView.swift
//  ArchitecturePractice
//
//  Created by 奥江英隆 on 2025/11/21.
//

import SwiftUI

struct TodoAddView: View {
    let onSave: (String, String) -> Void
    let onCancel: () -> Void

    @State private var title: String = ""
    @State private var description: String = ""

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
            .navigationTitle("新規Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        onCancel()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("追加") {
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
    TodoAddView(
        onSave: { _, _ in },
        onCancel: {}
    )
}
