//
//  EmailValidator.swift
//  ViewKit
//
//  Created by Baher Tamer on 20/09/2024.
//

import Foundation

struct EmailValidator: Validator {
    func validate(_ value: String) -> ValidationError? {
        guard !value.isEmpty else {
            return ValidationError("This Field Is Required")
        }
        
        guard isEmailValid(value) else {
            return ValidationError("The Email Address Is Invalid")
        }
        
        return nil
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
}
