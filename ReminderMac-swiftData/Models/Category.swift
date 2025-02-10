//
//  Note.swift
//  MacListDemo
//
//  Created by 林晓中 on 2025/2/7.
//

import Foundation
import SwiftUI

struct Category: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var color: Color
    
    static func examples() -> [Category] {
        [
            Category(
                title: "All",
                color: .green),
            Category(
                title: "Work",
                color: .blue),
            Category(
                title: "Home",
                color: .pink),
            Category(
                title: "Life",
                color: .yellow)
        ]
    }
}



