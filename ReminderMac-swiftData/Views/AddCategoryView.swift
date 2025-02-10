//
//  AddCategoryView.swift
//  ReminderMac-swiftData
//
//  Created by linxiaozhong on 2025/2/10.
//

import SwiftUI

struct AddCategoryView: View {
    
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var newCategoryTitle = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Category Name", text: $newCategoryTitle)
            }
            .navigationTitle("New Category")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let category = Category(title: newCategoryTitle, color: .blue)
                        modelContext.insert(category)
                        newCategoryTitle = ""
                        dismiss()
                    }
                    .disabled(newCategoryTitle.isEmpty)
                }
            }
        }
        .presentationDetents([.medium])
    }
    
}

#Preview {
    AddCategoryView()
}
