//
//  Note.swift
//  MacListDemo
//
//  Created by 林晓中 on 2025/2/7.
//

// Note.swift

import Foundation
import SwiftData

@Model
class Note: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var content: String
    var date: Date
    var isDone: Bool
    var category: String
    
    var isDoneFormatted: String {
        isDone ? "isDone" : "not"
    }
    
    init(id: UUID = UUID(), name: String, content: String, date: Date, isDone: Bool, category: String) {
        self.id = id
        self.name = name
        self.content = content
        self.date = date
        self.isDone = isDone
        self.category = category
    }
    
    static func examples() -> [Note] {
        [
            Note(
                name: "Shopping List",
                content:"Some shopping lists",
                date: Date(),
                isDone: true,
                category: "Work"
            ),
            Note(
                name: "Meeting Agenda for Q4",
                content:"1.set a meeting; 2.done.",
                date: Date.yesterday,
                isDone: false,
                category: "Work"
            ),
            Note(
                name: "Ideas",
                content:"Ideas are everything",
                date: Date.twoDaysAgo,
                isDone: true,
                category: "Life"
            )
        ]
    }
}

extension Date {
    
    static var yesterday: Date {
        var components = DateComponents()
        components.day = -1
        let result =  Calendar.current.date(byAdding: components, to: now)!
        return result
    }
    
    static var twoDaysAgo: Date {
        var components = DateComponents()
        components.day = -2
        let result =  Calendar.current.date(byAdding: components, to: now)!
        return result
    }
}



