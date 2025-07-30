//
//  CapsuleBorder.swift
//  ViewKit
//
//  Created by Baher Tamer on 11/09/2024.
//

import SwiftUI
import SwiftSafeUI

extension View {
    ///
    /// Adds an inner capsule-shaped border around a view with a specified style and line width.
    ///
    /// This function allows you to apply a capsule-shaped border to any view using a customizable `ShapeStyle` for the border color and appearance. You can also specify the line width of the border.
    ///
    /// ## Example:
    /// ``` swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         Text("Hello, World!")
    ///             .padding()
    ///             .capsuleBorder(style: .blue, lineWidth: 2)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - style: A generic `ShapeStyle` that defines the appearance of the border (e.g., Color, LinearGradient, etc.).
    ///   - lineWidth: A `CGFloat` value that specifies the width of the border line. The default value is `1`.
    ///
    /// - Returns: A `some View` that represents the modified view with the capsule-shaped border applied.
    ///
    public func capsuleBorder<Style: ShapeStyle>(
        style: Style,
        lineWidth: CGFloat = 1
    ) -> some View {
        modifier(
            CapsuleBorder(
                style: style,
                lineWidth: lineWidth
            )
        )
    }
}

fileprivate struct CapsuleBorder<Style: ShapeStyle>: ViewModifier {
    // MARK: - Inputs
    let style: Style
    let lineWidth: CGFloat
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .clipShape(.capsule)
            .overlay {
                Capsule()
                    .strokeBorder(style, lineWidth: lineWidth)
            }
    }
}
