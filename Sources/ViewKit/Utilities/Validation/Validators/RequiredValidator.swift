//
//  RequiredValidator.swift
//  ViewKit
//
//  Created by Baher Tamer on 20/09/2024.
//

import Foundation

struct RequiredValidator: Validator {
    func validate(_ value: String) -> ValidationError? {
        let isValid = isFieldValid(value)
        return isValid ? nil : ValidationError("This Field Is Required")
    }
    
    private func isFieldValid(_ text: String) -> Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
