//
//  ShareSheet.swift
//  ViewKit
//
//  Created by Baher Tamer on 24/09/2024.
//

import SwiftUI

extension View {
    /// Presents a share sheet for sharing items.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether the share sheet is currently presented.
    ///   - items: This can contain any type of objects conforming to the UIActivityItemSource protocol or types supported by the share sheet.
    ///
    /// - Returns: A `some` `view` that presents the share sheet with the specified items.
    ///
    /// ## Example:
    /// ``` swift
    /// struct ShareSheetView: View {
    ///     @State private var isPresented = false
    ///     private let shareText = "This is a sharable text from ViewKit!"
    ///
    ///     var body: some View {
    ///         Button("Share") {
    ///             isPresented.toggle()
    ///         }
    ///         .shareSheet(
    ///             isPresented: $isPresented,
    ///             items: [shareText]
    ///         )
    ///     }
    /// }
    ///```
    ///
    public func shareSheet(isPresented: Binding<Bool>, items: [Any]) -> some View {
        modifier(
            ShareSheet(
                isPresented: isPresented,
                items: items
            )
        )
    }
}

fileprivate struct ShareSheet: ViewModifier {
    // MARK: - Inputs
    @Binding var isPresented: Bool
    let items: [Any]
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .sheet(
                isPresented: $isPresented,
                content: shareSheet
            )
    }
    
    // MARK: - Components
    @ViewBuilder
    private func shareSheet() -> some View {
        if #available(iOS 16.0, *) {
            ShareView(items: items)
                .presentationDetents([.medium, .large])
        } else {
            ShareView(items: items)
        }
    }
}
