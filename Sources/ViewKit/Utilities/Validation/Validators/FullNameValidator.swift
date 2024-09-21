//
//  FullNameValidator.swift
//  ViewKit
//
//  Created by Baher Tamer on 20/09/2024.
//

import Foundation

struct FullNameValidator: Validator {
    func validate(_ value: String) -> ValidationError? {
        guard !value.isEmpty else {
            return ValidationError("This Field Is Required")
        }
        
        guard containsNoSpecialCharacters(value) else {
            return ValidationError("Full Name Must Contain Only Letters and Spaces")
        }
        
        guard isNameValid(value) else {
            return ValidationError("Full Name Must Consist of at Least a First Name and a Last Name")
        }
        
        return nil
    }
    
    /// Check if the full name contains no special characters.
    private func containsNoSpecialCharacters(_ name: String) -> Bool {
        let regex = "^[a-zA-Z\\s-]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: name)
    }
    
    /// Check if the full name consists of at least a first and last name.
    private func isNameValid(_ name: String) -> Bool {
        let components = name.split(separator: " ")
        return components.count >= 2
    }
}
