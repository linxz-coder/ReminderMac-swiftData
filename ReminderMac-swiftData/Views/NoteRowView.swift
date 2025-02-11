//
//  NoteRowView.swift

import SwiftUI
import SwiftData

struct NoteRowView: View {
    
    let note: Note
    @Environment(\.modelContext) private var context
    @State private var showingEditSheet = false
    @Query private var categories: [Category]
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading) {
                Text(note.name)
                Text(note.date, style: .date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
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
        }
        //MARK: - 右键菜单
        .contextMenu {
            
            //编辑按钮
            Button {
                showingEditSheet = true  // 显示编辑界面
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            
            //移动按钮
            Menu {
                ForEach(categories) { category in
                    if category.title != "All" && category.title != note.category {
                        Button {
                            // 移动到新分类
                            note.category = category.title
                            do {
                                try context.save()
                            } catch {
                                print("移动笔记时出错: \(error)")
                            }
                        } label: {
                            HStack {
                                Image(systemName: "folder.fill")
                                    .foregroundStyle(category.color,.blue)
                                Text(category.title)
                            }
                        }
                        .labelStyle(.titleAndIcon)
                    }
                }
            } label: {
                HStack {
                    Image(systemName: "folder")
                    Text("Move to...")
                }
            }
            .labelStyle(.titleAndIcon)
            //            .menuIndicator(.visible)
            
            //删除按钮
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
        //显示图标
        .labelStyle(.titleAndIcon)
        .sheet(isPresented: $showingEditSheet) {
            EditNoteView(note: note)
        }
    }
}

#Preview{
    NoteRowView(note: Note.examples()[0])
}
