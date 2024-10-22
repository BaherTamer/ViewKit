//
//  InputField.swift
//  ViewKit
//
//  Created by Baher Tamer on 20/09/2024.
//

import Combine
import SwiftUI

public struct InputField: View {
    // MARK: - Inputs
    @Binding private var text: String
    @Binding private var isSecure: Bool
    private let placeholder: String?
    private let localizedPlaceholder: LocalizedStringKey?
    private let validationType: ValidationType?
    private let onChangeValidation: ((ValidationError?) -> Void)?
    private let onEndValidation: ((ValidationError?) -> Void)?
    
    // MARK: - Variables
    @State private var typingCancellable: AnyCancellable?
    @State private var onTextChange = PassthroughSubject<String, Never>()
    
    // MARK: - Life Cycle
    ///
    /// Creates a `InputField` with a non localized placeholder.
    ///
    /// A customizable text field that supports validation, secure input, and optional placeholders.
    ///
    /// - Parameters:
    ///   - text: A binding to the text input, which updates the field’s content.
    ///   - isSecure: A binding to a `Bool` value that indicates whether the field is a secure text field. Default is `false`
    ///   - placeholder: An optional `String` that serves as a placeholder for the text field.
    ///   - validator: An optional ``ValidationType`` to be used for input validation.
    ///   - onChangeValidation: A closure that is called with an optional ``ValidationError`` when the text changes.
    ///   - onEndValidation: A closure that is called with an optional ``ValidationError`` when the user ends editing the field.
    ///
    /// ## Example
    /// ``` swift
    /// InputField(
    ///     $email,
    ///     placeholder: "Enter your email",
    ///     validator: .email,
    ///     onChangeValidation: { error in
    ///         // Display Error...
    ///     }
    /// )
    /// .keyboardType(.emailAddress)
    /// ```
    ///
    public init(
        _ text: Binding<String>,
        isSecure: Binding<Bool> = .constant(false),
        placeholder: String? = nil,
        validator: ValidationType? = nil,
        onChangeValidation: ((ValidationError?) -> Void)? = nil,
        onEndValidation: ((ValidationError?) -> Void)? = nil
    ) {
        self._text = text
        self._isSecure = isSecure
        self.placeholder = placeholder
        self.localizedPlaceholder = nil
        self.validationType = validator
        self.onChangeValidation = onChangeValidation
        self.onEndValidation = onEndValidation
    }
    
    ///
    /// Creates a `InputField` with a localized placeholder.
    ///
    /// A customizable text field that supports validation, secure input, and optional placeholders.
    ///
    /// - Parameters:
    ///   - text: A binding to the text input, which updates the field’s content.
    ///   - isSecure: A binding to a `Bool` value that indicates whether the field is a secure text field. Default is `false`
    ///   - localizedPlaceholder: A `LocalizedStringKey` that serves as a localized placeholder for the text field.
    ///   - validator: An optional ``ValidationType`` to be used for input validation.
    ///   - onChangeValidation: A closure that is called with an optional ``ValidationError`` when the text changes.
    ///   - onEndValidation: A closure that is called with an optional ``ValidationError`` when the user ends editing the field.
    ///
    /// ## Example
    /// ``` swift
    /// InputField(
    ///     $password,
    ///     isSecure: $isSecure,
    ///     localizedPlaceholder: "Enter your password",
    ///     validator: .password,
    ///     onEndValidation: { error in
    ///         // Display Error...
    ///     }
    /// )
    /// .font(.body.bold())
    /// ```
    ///
    public init(
        _ text: Binding<String>,
        isSecure: Binding<Bool> = .constant(false),
        localizedPlaceholder: LocalizedStringKey,
        validator: ValidationType? = nil,
        onChangeValidation: ((ValidationError?) -> Void)? = nil,
        onEndValidation: ((ValidationError?) -> Void)? = nil
    ) {
        self._text = text
        self._isSecure = isSecure
        self.placeholder = nil
        self.localizedPlaceholder = localizedPlaceholder
        self.validationType = validator
        self.onChangeValidation = onChangeValidation
        self.onEndValidation = onEndValidation
    }
    
    // MARK: - Body
    public var body: some View {
        inputField
            .onAppear(perform: debounce)
            .onDisappear(perform: cancel)
            .safeOnChange(
                text,
                perform: didChangeText
            )
    }
    
    // MARK: - Private Helpers
    private func debounce() {
        let seconds = ViewKitConfig.shared.inputFieldOnEndValidationDelay
        typingCancellable = onTextChange
            .debounce(
                for: .seconds(seconds),
                scheduler: RunLoop.main
            )
            .sink(receiveValue: didEndEditing)
    }
    
    private func send(_ value: String) {
        onTextChange
            .send(value)
    }
    
    private func cancel() {
        typingCancellable?
            .cancel()
    }
    
    private func didChangeText(_ oldValue: String, _ newValue: String) {
        send(newValue)
        if let validationType, let onChangeValidation {
            let error = validationType.validator.validate(text)
            onChangeValidation(error)
        }
    }
    
    private func didEndEditing(_ value: String) {
        if let validationType, let onEndValidation {
            let error = validationType.validator.validate(text)
            onEndValidation(error)
        }
    }
}

// MARK: - Components
extension InputField {
    @ViewBuilder
    private var inputField: some View {
        if let localizedPlaceholder {
            localizedPromptField(localizedPlaceholder)
        } else if let placeholder {
            promptField(placeholder)
        } else {
            noPromptField
        }
    }
    
    @ViewBuilder
    private var noPromptField: some View {
        if isSecure {
            SecureField(
                text: $text,
                prompt: nil,
                label: {}
            )
        } else {
            TextField(
                text: $text,
                prompt: nil,
                label: {}
            )
        }
    }
    
    @ViewBuilder
    private func promptField(_ prompt: String) -> some View {
        if isSecure {
            SecureField(
                text: $text,
                prompt: .init(verbatim: prompt),
                label: {}
            )
        } else {
            TextField(
                text: $text,
                prompt: .init(verbatim: prompt),
                label: {}
            )
        }
    }
    
    @ViewBuilder
    private func localizedPromptField(_ prompt: LocalizedStringKey) -> some View {
        if isSecure {
            SecureField(
                text: $text,
                prompt: .init(prompt),
                label: {}
            )
        } else {
            TextField(
                text: $text,
                prompt: .init(prompt),
                label: {}
            )
        }
    }
}
