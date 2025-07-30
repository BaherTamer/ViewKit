//
//  Hide.swift
//  ViewKit
//
//  Created by Baher Tamer on 13/10/2024.
//

import SwiftUI
import SwiftSafeUICore

extension View {
    ///
    /// Hide or show a view based on a Boolean flag without removing it from the view hierarchy.
    ///
    /// ## Example:
    /// ``` swift
    /// struct ContentView: View {
    ///     @State private var isViewHidden = false
    ///
    ///     var body: some View {
    ///         VStack {
    ///             Text("This is some content")
    ///                 .hide(isViewHidden)
    ///                 
    ///             Button("Toggle View Visibility") {
    ///                isViewHidden.toggle()
    ///            }
    ///        }
    ///    }
    ///}
    /// ```
    ///
    /// - Parameter isHidden: A Boolean value that determines whether the view should be hidden.
    ///
    /// - Returns: A modified view that is either hidden or shown.
    ///
    public func hide(_ isHidden: Bool) -> some View {
        modifier(
            HideViewModifier(isHidden: isHidden)
        )
    }
}

fileprivate struct HideViewModifier: ViewModifier {
    // MARK: - Inputs
    let isHidden: Bool
    
    // MARK: - Body
    func body(content: Content) -> some View {
        if isHidden {
            EmptyView()
        } else {
            content
        }
    }
}
