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
