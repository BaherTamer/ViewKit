//
//  RoundedCorners.swift
//  ViewKit
//
//  Created by Baher Tamer on 11/09/2024.
//

import SwiftUI

extension View {
    ///
    /// Rounds specified corners of a view with a given radius.
    ///
    /// This function provides a way to apply rounded corners to specific corners of a view using a custom `ViewModifier`.
    ///
    /// You can specify the radius for the rounding and which corners to round using `UIRectCorner`. The default behavior is to round all corners.
    ///
    /// The layout direction is taken into account to ensure the correct corners are rounded for both left-to-right and right-to-left layouts.
    ///
    /// ## Example:
    /// ``` swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         Rectangle()
    ///             .fill(.blue)
    ///             .frame(width: 200, height: 100)
    ///             .roundedCorners(20, corners: [.topLeft, .topRight])
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - radius: A `CGFloat` value that defines the radius of the rounded corners.
    ///   - corners: A `UIRectCorner` value that specifies which corners to round. The default is `.allCorners`, which rounds all corners of the view.
    ///
    /// - Returns: A `some View` that represents the modified view with rounded corners applied.
    ///
    public func roundedCorners(
        _ radius: CGFloat,
        corners: UIRectCorner = .allCorners
    ) -> some View {
        modifier(
            RoundedCorners(
                radius: radius,
                corners: corners
            )
        )
    }
}

fileprivate struct RoundedCorners: ViewModifier {
    // MARK: - Inputs
    let radius: CGFloat
    let corners: UIRectCorner
    
    // MARK: - Variables
    @Environment(\.layoutDirection) private var layoutDirection

    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .clipShape(
                RoundedShape(
                    radius: radius,
                    corners: adjustedCorners
                )
            )
    }

    // MARK: - Private Helpers
    private var adjustedCorners: UIRectCorner {
        layoutDirection == .rightToLeft ? corners.flipped : corners
    }
}

fileprivate struct RoundedShape: Shape {
    // MARK: - Inputs
    let radius: CGFloat
    let corners: UIRectCorner
    
    // MARK: - Variables
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        return Path(path.cgPath)
    }
}

fileprivate extension UIRectCorner {
    var flipped: UIRectCorner {
        var newCorners: UIRectCorner = []
        if contains(.topLeft) { newCorners.insert(.topRight) }
        if contains(.topRight) { newCorners.insert(.topLeft) }
        if contains(.bottomLeft) { newCorners.insert(.bottomRight) }
        if contains(.bottomRight) { newCorners.insert(.bottomLeft) }
        return newCorners
    }
}
