//
//  PickerBackground.swift
//  ViewKit
//
//  Created by Baher Tamer on 14/09/2024.
//

import SwiftUI

extension View {
    func pickerBackground() -> some View {
        modifier(PickerBackground())
    }
}

fileprivate struct PickerBackground: ViewModifier {
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .safeTintColor(ViewKitConfig.shared.appTintColor)
            .padding(.top, 8)
            .padding(.horizontal, 16)
            .padding(.bottom, 48)
            .background(.white)
            .roundedCorners(24, corners: [.topLeft, .topRight])
    }
}
