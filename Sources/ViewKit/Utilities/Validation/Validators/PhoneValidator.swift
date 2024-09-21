//
//  PhoneValidator.swift
//  ViewKit
//
//  Created by Baher Tamer on 20/09/2024.
//

import Foundation

struct PhoneValidator: Validator {
    func validate(_ value: String) -> ValidationError? {
        guard !value.isEmpty else {
            return ValidationError("This Field Is Required")
        }
        
        guard value.hasPrefix("01") else {
            return ValidationError("Phone Number Must Begin With 01")
        }
        
        guard value.count == 11 else {
            return ValidationError("Phone Number Must Be 11 Digits")
        }
        
        guard isNumberValid(value) else {
            return ValidationError("The Phone Number Is Invalid")
        }
        
        return nil
    }
    
    private func isNumberValid(_ number: String) -> Bool {
        let regex = "^(01)[0-9]{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: number)
    }
}
