//
//  NoteRowView.swift
//  MacTableDemo
//
//  Created by 林晓中 on 2025/2/7.
//

import SwiftUI

struct NoteRowView: View {
    
    let note: Note
    @Environment(\.modelContext) private var context
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading) {
                Text(note.name)
                Text(note.date, style: .date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
//            if note.isDone {
//                Image(systemName: "checkmark")
//                    .foregroundColor(.blue)
//            }
            Toggle("", isOn: Binding(
                get: {note.isDone},
                set: { newValue in
                    note.isDone = newValue
                    do{
                        try context.save()
                    } catch {
                        print("保存数据出错：\(error)")
                    }
                }
            )).toggleStyle(.switch)
        }//删除条目
        .contextMenu {
            Button {
                context.delete(note)
                do {
                    try context.save()  // 提交更改
                } catch {
                    print("删除项目时出错: \(error)")
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
        }
    }
}

#Preview{
    NoteRowView(note: Note.examples()[0])
}
