//
//  NoteItemView.swift
import SwiftUI


struct NoteItemView: View {
    let note: Note
    @State private var isShow: Bool = false
    
    var body: some View {
        Button {
            isShow.toggle()
        } label: {
            GroupBox {
                NoteRowView(note: note)
            }
        }
        .buttonStyle(.plain)
        .popover(isPresented: $isShow, arrowEdge: .leading) {
            Text(note.content) // 显示对应note的内容
                .padding()
        }
        

    }
}

#Preview{
    NoteItemView(note: Note.examples()[0])
}
