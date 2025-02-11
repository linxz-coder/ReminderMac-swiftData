//
// Category.swift

import Foundation
import SwiftUI
import SwiftData

@Model
class Category: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var colorHex: String  // 存储颜色的十六进制字符串
    
    var color: Color {    // 计算属性转换为 Color
        Color(hex: colorHex) ?? .blue
    }
    
    init(id: UUID = UUID(), title: String, color: Color) {
        self.id = id
        self.title = title
        self.colorHex = color.toHex() ?? "#0000FF"
    }
    
    static func examples() -> [Category] {
        [
            Category(
                title: "All",
                color: .gray),
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

extension Color {
    func toHex() -> String? {
        // 转换 Color 为十六进制
        guard let components = NSColor(self).cgColor.components else { return nil }
        let r = Int(components[0] * 255.0)
        let g = Int(components[1] * 255.0)
        let b = Int(components[2] * 255.0)
        return String(format: "#%02X%02X%02X", r, g, b)
    }
    
    init?(hex: String) {
        // 从十六进制创建 Color
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        self.init(red: Double((rgb & 0xFF0000) >> 16) / 255.0,
                 green: Double((rgb & 0x00FF00) >> 8) / 255.0,
                 blue: Double(rgb & 0x0000FF) / 255.0)
    }
}



