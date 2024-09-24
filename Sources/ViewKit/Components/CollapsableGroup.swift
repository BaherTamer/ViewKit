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
    
    // MARK: - Life Cycle
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
            contentView
        }
    }
    
    // MARK: - Private Helpers
    private func toggleExpanded() {
        if isHeaderTappable {
            isExpanded.toggle()
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
    
    @ViewBuilder
    private var contentView: some View {
        if isExpanded {
            content
        }
    }
}
