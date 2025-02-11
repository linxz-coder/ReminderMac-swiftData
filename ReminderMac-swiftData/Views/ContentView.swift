//  ContentView.swift


import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Category.title) private var categories: [Category]
    @Query private var notes: [Note]
    @State private var showingAddNote = false
    @State private var showingAddCategory = false
    @State private var showDeleteAlert: Bool = false
    @State var selection: Category?
    @State var inspectorIsShow: Bool = true
    
    
    var body: some View {
        NavigationSplitView {
            List(categories, selection: $selection){ category in
                Label(category.title, systemImage: "note.text")
//                    .foregroundStyle(category.color)
                    .tag(category)
                    .contextMenu {
                        Button {
                            showDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        
                    }
                //右键菜单图标显示
                    .labelStyle(.titleAndIcon)
                
            }
            
            Spacer()
            HStack {
                Button {
                    //Add Categories
                    showingAddCategory = true
                } label: {
                    Image(systemName: "plus.circle")
                    Text("Category")
                }.buttonStyle(.plain)
                //MARK: - 新建category
                    .sheet(isPresented: $showingAddCategory) {
                        AddCategoryView()
                    }
                Spacer()
                
                
            }.padding()
                .onAppear {
                    
                    //载入初始分类
                    if categories.isEmpty {
                        for category in Category.examples() {
                            modelContext.insert(category)
                        }
                        try? modelContext.save()
                    }
                    
                    //选中第一个分类
                    if let firstCategory = categories.first {
                        selection = firstCategory
                    }
                }
            //MARK: - 删除Category
                .alert("Delete Category [\(selection?.title ?? "")]", isPresented: $showDeleteAlert) {
                    
                    //All不允许删除
                    if let category = selection, category.title == "All" {
                        // 如果是 All category，只显示确认按钮
                        Button("OK", role: .cancel) { }
                    } else {
                        //删除Category及note
                        Button("Delete", role: .destructive) {
                            if let categoryToDelete = selection {
                                let categoryTitle = categoryToDelete.title
                                
                                // 1. 获取所有Notes
                                let notesDescriptor = FetchDescriptor<Note>()
                                if let allNotes = try? modelContext.fetch(notesDescriptor) {
                                    // 找出属于该category的notes并删除
                                    let notesToDelete = allNotes.filter { $0.category == categoryTitle }
                                    for note in notesToDelete {
                                        modelContext.delete(note)
                                    }
                                }
                                
                                // 2. 删除Category本身
                                modelContext.delete(categoryToDelete)
                                
                                // 3. 保存更改
                                do {
                                    try modelContext.save()
                                    // 4. 清除选择
                                    selection = nil
                                } catch {
                                    print("删除Category时出错: \(error)")
                                }
                            }
                        }
                    }
                } message: {
                    if let category = selection, category.title == "All" {
                        Text("Cannot delete the 'All' category as it is required by the system.")
                    } else {
                        Text("Are you sure you want to delete this category and all its associated notes?")
                    }
                }
        } detail: {
            GroupBoxView(currentCatogory: selection)
        }
//        .toolbarBackground(Color(nsColor: .blue).opacity(0.3), for: .windowToolbar)
        
        //MARK: - 新建项目
        .toolbar {
            Button(action: {
                showingAddNote = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showingAddNote) {
            AddNoteView(currentCategory: selection)
        }
        //MARK: - 导航标题
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .navigation) {
                HStack {
                    Circle()
                        .fill(selection?.color ?? .primary)
                        .frame(width: 10, height: 10)
                    Text(selection?.title ?? "Reminder")
                        .font(.headline)
                }
            }
        }

    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Note.self, Category.self])
}
