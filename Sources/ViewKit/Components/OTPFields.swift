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
    ///
    /// Displays a series of customizable input fields for entering a One-Time Password (OTP).
    ///
    /// - Parameters:
    ///   - pins: A binding to an array of strings representing the individual pins for the OTP fields. It is important that this array is initialized with empty strings to ensure proper count behavior, as the view relies on the number of elements in this array to determine how many fields to display.
    ///   - spacing: The spacing between the OTP fields. Default value is `24`.
    ///   - content: A closure that produces the content for each OTP field. It takes two parameters:
    ///     - An `Int` representing the index of the current field.
    ///     - A `Bool` indicating whether the field is currently focused.
    ///   - onSubmit: A closure that is called when all values are added.
    ///
    /// ## Example:
    /// ``` swift
    /// struct ContentView: View {
    ///     @State private var pins = [String](repeating: "", count: 4)
    ///
    ///     var body: some View {
    ///         OTPFields(pins: $pins, spacing: 21) { index, isFocused in
    ///             TextField(text: $pins[index], label: {})
    ///                 .font(.title3.bold())
    ///                 .foregroundStyle(.blue)
    ///                 .frame(width: 74, height: 84)
    ///                 .roundedBorder(radius: 20, style: Color.secondary)
    ///                 .background {
    ///                     Rectangle()
    ///                         .fill(.secondary)
    ///                         .frame(height: 1)
    ///                         .padding(.horizontal, 20)
    ///                         .opacity(pins[index].isEmpty ? 1 : 0)
    ///                 }
    ///         } onSubmit: {
    ///             // All values are added...
    ///         }
    ///         .padding()
    ///     }
    /// }
    /// ```
    ///
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
