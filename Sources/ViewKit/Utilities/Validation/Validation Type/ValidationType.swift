//
//  ValidationType.swift
//  ViewKit
//
//  Created by Baher Tamer on 20/09/2024.
//

public enum ValidationType {
    case email
    case fullName
    case nationalId
    case password
    case phone
    /// Validation to ensure that a field is not left empty or with white spaces only.
    case required
    /// Allows for the use of a custom validation logic by providing a Validator instance.
    case custom(Validator)
}
