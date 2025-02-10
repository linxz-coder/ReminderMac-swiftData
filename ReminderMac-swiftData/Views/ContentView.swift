//  ContentView.swift


import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var categories = Category.examples()
    @State private var showingAddNote = false
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
                } label: {
                    Image(systemName: "plus.circle")
                    Text("Category")
                }.buttonStyle(.plain)
                Spacer()
            }.padding()
                // 默认选中第一项 - All
                .onAppear {
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
        .modelContainer(for: Note.self)
}
