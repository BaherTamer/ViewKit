//
//  Validator.swift
//  ViewKit
//
//  Created by Baher Tamer on 20/09/2024.
//

public protocol Validator {
    ///
    /// Validates the provided `String` value and returns an optional ``ValidationError``.
    ///
    /// If the value is valid, it returns `nil`; otherwise, it returns an error detailing why the validation failed.
    ///
    func validate(_ value: String) -> ValidationError?
    
    ///
    /// Determines whether the provided `String` value is valid.
    ///
    /// This method checks the validity of the value by utilizing the validate method.
    /// It returns `true` if the value is valid and `false` otherwise.
    ///
    func isValid(_ value: String) -> Bool
}

public extension Validator {
    func isValid(_ value: String) -> Bool {
        validate(value) == nil
    }
}
