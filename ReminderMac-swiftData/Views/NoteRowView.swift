//
//  NoteRowView.swift
//  MacTableDemo
//
//  Created by 林晓中 on 2025/2/7.
//

import SwiftUI

struct NoteRowView: View {
    
    let note: Note
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading) {
                Text(note.name)
                Text(note.date, style: .date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if note.isDone {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
    }
}
