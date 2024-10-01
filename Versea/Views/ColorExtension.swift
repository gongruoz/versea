//
//  ColorExtension.swift
//  Versea
//
//  Created by Hazel Gong on 2024/9/29.
//

import Foundation
import SwiftUI

// Helper extension to create Color from hex string
extension Color {
    static func randomCustomColor() -> Color {
        let hexColors = [
            "D9ABE7", "F1EC75", "FF7A2F", "B38DFF",
            "26B5E9", "7BCDAB", "AFD3B3", "D8B8CE",
            "EBC443", "E6819B", "B798CA", "DC8F4B",
            "FF7B69", "2365AF"
        ]

        let randomHex = hexColors.randomElement() ?? "000000"
        return Color.fromHex(randomHex)
    }

    static func fromHex(_ hex: String) -> Color {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }

        guard hexFormatted.count == 6 else {
            return Color.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        return Color(red: red, green: green, blue: blue)
    }
}
