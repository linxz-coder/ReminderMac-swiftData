// AddNoteView.swift
import SwiftUI

struct AddNoteView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    let currentCategory: Category?
    
    @State private var noteName: String = ""
    @State private var noteContent: String = ""
    @State private var isDone: Bool = false
    
    var body: some View {
        Form {
            TextField("Note Name", text: $noteName)
            TextField("Note Content", text: $noteContent)
            Toggle("Is Done", isOn: $isDone)
            
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                
                Button("Add") {
                    let newNote = Note(
                        name: noteName,
                        content: noteContent,
                        date: Date(),
                        isDone: isDone,
                        category: currentCategory?.title ?? "Uncategorized"
                    )
                    context.insert(newNote)
                    do {
                        try context.save()  // 保存上下文的所有更改
                        dismiss()
                    } catch {
                        print("保存数据时出错: \(error)")
                    }
                }
                .disabled(noteName.isEmpty)
            }
        }
        .padding()
        .frame(width: 300, height: 200)
    }
}
