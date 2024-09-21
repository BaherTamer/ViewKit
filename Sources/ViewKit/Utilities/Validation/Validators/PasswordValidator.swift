//
//  PasswordValidator.swift
//  ViewKit
//
//  Created by Baher Tamer on 20/09/2024.
//

import Foundation

struct PasswordValidator: Validator {
    func validate(_ value: String) -> ValidationError? {
        guard !value.isEmpty else {
            return ValidationError("This Field Is Required")
        }
        
        guard !value.contains(" ") else {
            return ValidationError("Password Must Not Contain Spaces")
        }
        
        guard value.count >= 8 else {
            return ValidationError("Password Must Be at Least 8 Characters Long")
        }
        
        guard containsUppercase(value) else {
            return ValidationError("Password Must Contain at Least One Uppercase Letter")
        }
        
        guard containsLowercase(value) else {
            return ValidationError("Password Must Contain at Least One Lowercase Letter")
        }
        
        
        guard containsNumber(value) else {
            return ValidationError("Password Must Contain at Least One Number")
        }
        
        
        guard containsSpecialCharacter(value) else {
            return ValidationError("Password Must Contain at Least One Special Character")
        }
        
        return nil
    }
    
    /// Check if the password contains at least one uppercase letter.
    private func containsUppercase(_ password: String) -> Bool {
        let regex = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }

    /// Check if the password contains at least one lowercase letter.
    private func containsLowercase(_ password: String) -> Bool {
        let regex = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }

    /// Check if the password contains at least one number.
    private func containsNumber(_ password: String) -> Bool {
        let regex = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }

    /// Check if the password contains at least one special character.
    private func containsSpecialCharacter(_ password: String) -> Bool {
        let regex = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }
}
