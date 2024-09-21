//
//  ValidationError.swift
//  ViewKit
//
//  Created by Baher Tamer on 20/09/2024.
//

import Foundation

public struct ValidationError: Error {
    /// A `String` that contains the localized error message.
    public let message: String
    
    /// Creates a instance with a localized error message.
    public init(_ message: String.LocalizationValue) {
        self.message = String(localized: message)
    }
}
