//
//  AddCategoryView.swift


import SwiftUI

struct AddCategoryView: View {
    
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var newCategoryTitle = ""
    @State private var selectedColor: Color = .blue  // 添加颜色选择
    
    let colorOptions: [Color] = [.blue, .green, .red, .orange, .yellow, .purple, .brown, .gray]
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Category Name", text: $newCategoryTitle).padding()
                
                LabeledContent("Category Color", value: "choose your color")
                
                //颜色选择器
                HStack {
                    ForEach(colorOptions, id: \.self) { color in
                        Image(systemName: selectedColor == color ? "record.circle.fill" : "circle.fill")
                            .foregroundStyle(color)
                            .onTapGesture {
                                selectedColor = color
                            }
                    }
                }
                .padding(.vertical)
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
                        let category = Category(title: newCategoryTitle, color: selectedColor)
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
