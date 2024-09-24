//
//  CollapsableGroup.swift
//  ViewKit
//
//  Created by Baher Tamer on 24/09/2024.
//

import SwiftUI

public struct CollapsableGroup<Header: View, Content: View>: View {
    // MARK: - Inputs
    @Binding private var isExpanded: Bool
    private let isHeaderTappable: Bool
    private let spacing: CGFloat
    private let header: Header
    private let content: Content
    
    // MARK: - Variables
    @Namespace private var namespace
    private let springAnimation = Animation.spring(
        response: 0.6,
        dampingFraction: 0.8
    )
    
    // MARK: - Life Cycle
    ///
    /// Creates a `CollapsableGroup` with a header and content view, providing optional customizations.
    ///
    /// - Parameters:
    ///   - isExpanded: A binding to a Boolean value that determines whether the group is expanded or collapsed. When `true`, the content is visible, otherwise, it is hidden.
    ///   - isHeaderTappable: A Boolean value that indicates whether tapping on the header should toggle the collapsed/expanded state. The default is `true`.
    ///   - spacing: A `CGFloat` value representing the vertical spacing between the header and the content. The default is `8`.
    ///   - header: A `ViewBuilder` that constructs the view to be used as the header of the collapsable group.
    ///   - content: A `ViewBuilder` that constructs the view to be used as the content of the collapsable group, which will be shown or hidden based on the `isExpanded` state.
    ///
    /// The `CollapsableGroup` offers a collapsible view group, with the ability to customize its header, content, and spacing, and provides the option for users to tap the header to toggle the expanded state. The `header` and `content` views are passed as closures and the expanded state is controlled externally through the `isExpanded` binding.
    ///
    /// ## Example:
    /// ```swift
    /// @State private var isExpanded = false
    ///
    /// var body: some View {
    ///     CollapsableGroup(isExpanded: $isExpanded) {
    ///         HStack {
    ///             Text("Header")
    ///             Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
    ///         }
    ///     } content: {
    ///         Text("Content")
    ///     }
    /// }
    /// ```
    ///
    public init(
        isExpanded: Binding<Bool>,
        isHeaderTappable: Bool = true,
        spacing: CGFloat = 8,
        @ViewBuilder header: () -> Header,
        @ViewBuilder content: () -> Content
    ) {
        self._isExpanded = isExpanded
        self.isHeaderTappable = isHeaderTappable
        self.spacing = spacing
        self.header = header()
        self.content = content()
    }
    
    // MARK: - Body
    public var body: some View {
        VStack(spacing: spacing) {
            headerView
            
            if isExpanded {
                contentView
            }
        }
    }
    
    // MARK: - Private Helpers
    private func toggleExpanded() {
        if isHeaderTappable {
            withAnimation(springAnimation) {
                isExpanded.toggle()
            }
        }
    }
}

// MARK: - Components
extension CollapsableGroup {
    private var headerView: some View {
        header
            .onTapGesture(
                perform: toggleExpanded
            )
    }
    
    private var contentView: some View {
        content
            .matchedGeometryEffect(id: "view", in: namespace)
            .mask(
                Rectangle()
                    .matchedGeometryEffect(id: "mask", in: namespace)
            )
    }
}
