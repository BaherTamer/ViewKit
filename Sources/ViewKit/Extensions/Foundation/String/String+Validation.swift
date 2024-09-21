//
//  File.swift
//  ViewKit
//
//  Created by Baher Tamer on 20/09/2024.
//

public extension String {
    ///
    /// Validates the `String` based on the provided validation type and returns a validation error if the `String` does not meet the required criteria.
    ///
    /// This method takes a ``ValidationType`` as input, which defines the validation criteria for the string.
    /// It uses the associated ``Validator`` from the ``ValidationType`` to validate the string.
    ///
    /// If the string fails to meet the validation requirements, a ``ValidationError`` is returned.
    /// If the string is valid, it returns `nil`.
    ///
    /// This method is useful when you need detailed feedback about why a `String` is invalid.
    ///
    /// ## Examples:
    /// ``` swift
    /// let email = "example@example.com"
    /// if let error = email.validate(type: .email) {
    ///     print("Invalid email: \(error.message)")
    /// } else {
    ///     print("Email is valid")
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - type: A ``ValidationType`` that defines the type of validation to be performed on the `String`.
    ///
    /// - Returns:
    /// A optional ``ValidationError`` indicating the result of the validation.\
    /// If the `String` is valid, it returns `nil`.
    /// If the `String` is invalid, it returns a ``ValidationError`` that describes the issue.
    ///
    func validate(type: ValidationType) -> ValidationError? {
        type.validator.validate(self)
    }
    
    ///
    /// Checks whether the `String` is valid based on the provided validation type.
    ///
    /// This method quickly determines if a `String` passes the validation defined by the provided ``ValidationType``.
    ///
    /// It is a more concise version of the ``validate(type:)`` method, which only returns a boolean value instead of a detailed error.
    /// 
    /// This function is suitable for situations where only a pass/fail result is required, without the need for specific error information.
    ///
    /// ## Examples:
    /// ``` swift
    /// let email = "example@example.com"
    /// if email.isValid(type: .email) {
    ///     print("Email is valid")
    /// } else {
    ///     print("Email is not valid")
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - type: A ``ValidationType`` that defines the type of validation to be performed on the `String`.
    ///
    /// - Returns:
    /// A `Bool` indicating whether the `String` is valid.\
    /// Returns `true` if the `String` passes the validation, or `false` if it does not.
    ///
    func isValid(type: ValidationType) -> Bool {
        type.validator.isValid(self)
    }
}
