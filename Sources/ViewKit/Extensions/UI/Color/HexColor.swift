//
//  HexColor.swift
//  ViewKit
//
//  Created by Baher Tamer on 12/09/2024.
//

import SwiftUI
import SwiftSafeUI

extension Color {
    ///
    /// Initializes a `Color` from a hexadecimal `String`.
    ///
    /// This initializer allows you to create a `Color` instance using a hexadecimal string that represents the color in either RGB (12-bit, 24-bit) or ARGB (32-bit) formats.
    ///
    /// **It supports different hex string lengths:**
    /// - 3 characters (RGB, 12-bit), where each digit is repeated.
    /// - 6 characters (RGB, 24-bit), where no alpha value is provided (assumes fully opaque).
    /// - 8 characters (ARGB, 32-bit), where the first two characters represent the alpha (opacity) value.
    ///
    /// If the provided hex string is invalid or not in one of the expected formats, the initializer defaults to an opaque black color (#000000).
    ///
    /// ## Examples:
    /// ``` swift
    /// let color1 = Color(hex: "#FF5733") // RGB (24-bit)
    /// let color2 = Color(hex: "#FFF") // RGB (12-bit)
    /// let color3 = Color(hex: "#80FF5733") // ARGB (32-bit)
    /// ```
    ///
    /// > Tip: For cases where you need transparency, use an 8-character hex string (ARGB) to specify the alpha value directly.
    ///
    /// > Important: Ensure that the hex string you provide is valid and in one of the supported formats (3, 6, or 8 characters). If not, the initializer will return a black color by default.
    ///
    /// - Parameters:
    ///   - hex: A `String` representing the hexadecimal color value. \
    ///   It can include the hash symbol `(#)` at the beginning, and the initializer will ignore any non-alphanumeric characters.
    ///
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        let a, r, g, b: UInt64
        var int: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&int)
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
