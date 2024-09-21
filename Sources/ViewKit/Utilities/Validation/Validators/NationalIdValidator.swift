//
//  NationalIdValidator.swift
//  ViewKit
//
//  Created by Baher Tamer on 20/09/2024.
//

import Foundation

struct NationalIdValidator: Validator {
    func validate(_ value: String) -> ValidationError? {
        guard !value.isEmpty else {
            return ValidationError("This Field Is Required")
        }
        
        guard containsOnlyDigits(value) else {
            return ValidationError("National Number Must Contain Only Digits")
        }
        
        guard value.count == 14 else {
            return ValidationError("National Number Must Be Exactly 14 Digits Long")
        }
        
        guard isNumberValid(value) else {
            return ValidationError("The National Number Is Invalid")
        }
        
        return nil
    }
    
    private func containsOnlyDigits(_ number: String) -> Bool {
        let regex = "^[0-9]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: number)
    }
    
    private func isNumberValid(_ number: String) -> Bool {
        let regex = "^[2-3][0-9]{13}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: number)
    }
}
