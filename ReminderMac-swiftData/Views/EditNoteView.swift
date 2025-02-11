//
//  EditNoteView.swift

import SwiftUI

struct EditNoteView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    let note: Note
    @State private var editedName: String
    @State private var editedContent: String
    @State private var editedIsDone: Bool
    
    init(note: Note) {
        self.note = note
        // 初始化状态变量
        _editedName = State(initialValue: note.name)
        _editedContent = State(initialValue: note.content)
        _editedIsDone = State(initialValue: note.isDone)
    }
    
    var body: some View {
        Form {
            TextField("Note Name", text: $editedName)
            TextField("Note Content", text: $editedContent)
            Toggle("Is Done", isOn: $editedIsDone)
            
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                
                Button("Save") {
                    // 更新note的属性
                    note.name = editedName
                    note.content = editedContent
                    note.isDone = editedIsDone
                    
                    do {
                        try context.save()
                        dismiss()
                    } catch {
                        print("保存修改时出错: \(error)")
                    }
                }
                .disabled(editedName.isEmpty)
            }
        }
        .padding()
        .frame(width: 300, height: 200)
    }
}
