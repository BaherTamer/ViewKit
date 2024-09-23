//
//  CircleBorder.swift
//  ViewKit
//
//  Created by Baher Tamer on 21/09/2024.
//

import SwiftUI

extension View {
    ///
    /// Adds a circle-shaped border around a view with a specified style and line width.
    ///
    /// This function allows you to apply a circle-shaped border to any view using a customizable `ShapeStyle` for the border color and appearance. You can also specify the line width of the border.
    ///
    /// ## Example:
    /// ``` swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         Text("Hello, World!")
    ///             .padding()
    ///             .circleBorder(style: .blue, lineWidth: 2)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - style: A generic `ShapeStyle` that defines the appearance of the border (e.g., Color, LinearGradient, etc.).
    ///   - lineWidth: A `CGFloat` value that specifies the width of the border line. The default value is `1`.
    ///
    /// - Returns: A `some View` that represents the modified view with the circle-shaped border applied.
    ///
    public func circleBorder<Style: ShapeStyle>(
        style: Style,
        lineWidth: CGFloat = 1
    ) -> some View {
        modifier(
            CircleBorder(
                style: style,
                lineWidth: lineWidth
            )
        )
    }
}

fileprivate struct CircleBorder<Style: ShapeStyle>: ViewModifier {
    // MARK: - Inputs
    let style: Style
    let lineWidth: CGFloat
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .clipShape(.circle)
            .overlay {
                Circle()
                    .stroke(style, lineWidth: lineWidth)
            }
    }
}
