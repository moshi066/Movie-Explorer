//
//  Color+Extension.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 5/3/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        let alpha = hexSanitized.count == 8 ? Double((rgb >> 24) & 0xFF) / 255.0 : 1.0
        
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
