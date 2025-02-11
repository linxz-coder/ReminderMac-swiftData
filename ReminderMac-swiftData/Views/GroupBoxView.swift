import SwiftUI
import SwiftData

struct GroupBoxView: View {
    
    @Query private var notes: [Note]
    var currentCatogory: Category?
    
    
    var filteredNotes: [Note] {
        
        if currentCatogory?.title == "All"{
            return notes
        }
        
        guard let category = currentCatogory else {
            return notes // 如果没有选择分类，返回所有笔记
        }
        return notes.filter { $0.category == category.title }
    }
    
    //    func delete(note: Note){
    //        if let index = notes.firstIndex(of: note){
    //            notes.remove(at: index)
    //        }
    //    }
    
    var body: some View {
        List() {
            ForEach(filteredNotes) { note in
                NoteItemView(note: note)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top:4, leading: 0,bottom: 4,trailing: 0))
            }
        }
        
    }
}

#Preview {
    let container = {
        let container = try! ModelContainer(for: Note.self, Category.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        Note.examples().forEach { container.mainContext.insert($0) }
        return container
    }()
    
    return GroupBoxView(currentCatogory: Category.examples()[0])
        .frame(width: 300)
        .modelContainer(container)
}
