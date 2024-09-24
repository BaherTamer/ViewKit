//
//  OTPFields.swift
//  ViewKit
//
//  Created by Baher Tamer on 24/09/2024.
//

import SwiftUI

public struct OTPFields<Content: View>: View {
    // MARK: - Inputs
    @Binding private var pins: [String]
    private let spacing: CGFloat
    @ViewBuilder private let content: (Int, Bool) -> Content
    private let onSubmit: () -> Void
    
    // MARK: - Variables
    @FocusState private var focusedIndex : Int?
    
    // MARK: - Life Cycle
    public init(
        pins: Binding<[String]>,
        spacing: CGFloat = 24,
        content: @escaping (Int, Bool) -> Content,
        onSubmit: @escaping () -> Void
    ) {
        self._pins = pins
        self.spacing = spacing
        self.content = content
        self.onSubmit = onSubmit
    }
    
    // MARK: - Body
    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(
                0 ..< pins.count,
                id: \.self,
                content: contentField
            )
        }
        .safeOnChange(
            focusedIndex ?? -1,
            perform: focusedIndexDidChange
        )
    }
    
    // MARK: - Components
    private func contentField(_ index: Int) -> some View {
        content(index, focusedIndex == index)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .focused($focusedIndex, equals: index)
            .safeOnChange(pins[index]) { oldValue, newValue in
                limitText(oldValue, newValue, index: index)
                updateFocusedIndex(for: newValue)
            }
    }
}

// MARK: - Private Helpers
extension OTPFields {
    private func focusedIndexDidChange(_ oldValue: Int, _ newValue: Int) {
        let isLastField = oldValue == (pins.count - 1)
        let isNil = newValue == -1
        if isLastField && isNil { onSubmit() }
    }
    
    /// Updates the value of a pin to be only 1 value, handles whether the added character is at the prefix or suffix of the pin depending on the text field cursor position.
    private func limitText(_ oldValue: String, _ newValue: String, index : Int) {
        guard pins[index].count > 1 else { return }
        
        let pin = pins[index]
        let firstOldChar = oldValue.prefix(1)
        let firstNewChar = newValue.prefix(1)
        let isSamePrefix = firstOldChar == firstNewChar
        let suffix = String(pin.suffix(1))
        let prefix = String(pin.prefix(1))
        
        pins[index] = isSamePrefix ? suffix : prefix
    }
    
    /// Updates the currently focused index of OTP fields, wether to move to next/previous field.
    private func updateFocusedIndex(for pin: String) {
        guard let focusedIndex else {
            focusedIndex = nil
            return
        }
        
        if !pin.isEmpty {
            let isLastField = focusedIndex == (pins.count - 1)
            self.focusedIndex = isLastField ? nil : focusedIndex + 1
        } else {
            let isFirstField = focusedIndex == 0
            self.focusedIndex = isFirstField ? nil : focusedIndex - 1
        }
    }
}
