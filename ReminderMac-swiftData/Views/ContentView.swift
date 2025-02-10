//  ContentView.swift


import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Category.title) private var categories: [Category]
    @State private var showingAddNote = false
    @State private var showingAddCategory = false
    @State var selection: Category?
    @State var inspectorIsShow: Bool = true
    
    
    var body: some View {
        NavigationSplitView {
            List(categories, selection: $selection){
                Label($0.title, systemImage: "note.text")
                    .tag($0)
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
        } detail: {
            GroupBoxView(currentCatogory: selection)
        }
        
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
        //MARK: - 标题
        .navigationTitle("Reminder")
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Note.self, Category.self])
}
