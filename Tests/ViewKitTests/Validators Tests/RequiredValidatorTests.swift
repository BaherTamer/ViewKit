//
//  RequiredValidatorTests.swift
//  ViewKit
//
//  Created by Baher Tamer on 21/09/2024.
//

import Testing
@testable import ViewKit

struct RequiredValidatorTests {
    // MARK: - Setup
    private let requiredValidator = ValidationType.required.validator
    
    // MARK: - Valid Cases
    @Test("Valid Input")
    private func validRequiredInput() {
        let input = "Testing"
        let isValid = requiredValidator.isValid(input)
        #expect(isValid)
    }
    
    // MARK: - Invalid Cases
    @Test("Invalid Empty")
    private func invalidEmptyRequiredInput() {
        let input = ""
        let isValid = requiredValidator.isValid(input)
        #expect(!isValid)
    }
    
    @Test("Invalid Spaces")
    private func invalidRequiredInputWithOnlySpaces() {
        let input = " "
        let isValid = requiredValidator.isValid(input)
        #expect(!isValid)
    }
}
