//
//  DashedLine.swift
//  ViewKit
//
//  Created by Baher Tamer on 23/10/2024.
//

import SwiftUI

public struct DashedLine: View {
    // MARK: - Inputs
    let color: Color
    let lineWidth: CGFloat
    let dash: CGFloat
    let direction: LineDirection
    
    // MARK: - Variables
    private var width: CGFloat? {
        direction == .vertical ? lineWidth : nil
    }
    
    private var height: CGFloat? {
        direction == .horizontal ? lineWidth : nil
    }
    
    // MARK: - Life Cycle
    ///
    /// Draws a dashed line that can be either horizontal or vertical, and it's appearance can be customized with various parameters such as color, line width, and dash length.
    ///
    /// - Parameters:
    ///   - color: The color of the dashed line.
    ///   - lineWidth: The width of the line. The default value is `1`.
    ///   - dash: The length of each dash segment in the line. The default value `10`.
    ///   - direction: The direction of the line, either `.horizontal` or `.vertical`. The default value is `.horizontal`.
    ///
    /// ## Example:
    ///
    /// ``` swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         VStack {
    ///             // Horizontal dashed line
    ///             DashedLine(
    ///                 color: .gray,
    ///                 lineWidth: 2,
    ///                 dash: 5,
    ///                 direction: .horizontal
    ///             )
    ///             .frame(height: 1)
    ///
    ///             // Vertical dashed line
    ///             DashedLine(
    ///                 color: .blue,
    ///                 lineWidth: 2,
    ///                 dash: 8,
    ///                 direction: .vertical
    ///             )
    ///             .frame(width: 1, height: 100)
    ///         }
    ///     }
    /// }
    /// ```
    ///
    public init(
        color: Color,
        lineWidth: CGFloat = 1,
        dash: CGFloat = 10,
        direction: LineDirection = .horizontal
    ) {
        self.color = color
        self.lineWidth = lineWidth
        self.dash = dash
        self.direction = direction
    }
    
    // MARK: - Body
    public var body: some View {
        Line()
            .stroke(
                style: StrokeStyle(
                    lineWidth: lineWidth,
                    dash: [dash]
                )
            )
            .fill(color)
            .frame(width: width, height: height)
    }
}
