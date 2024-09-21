//
//  CustomValidatorTests.swift
//  ViewKit
//
//  Created by Baher Tamer on 21/09/2024.
//

import Testing
@testable import ViewKit

struct CustomValidatorTests {
    // MARK: - Setup
    private let evenNumberValidator = ValidationType.custom(
        EvenNumberValidator()
    ).validator
    
    // MARK: - Valid Cases
    @Test("Valid Even Number")
    private func validEvenNumber() {
        let number = "6"
        let isValid = evenNumberValidator.isValid(number)
        #expect(isValid)
    }
    
    // MARK: - Invalid Cases
    @Test("Invalid Odd Number")
    private func invalidOddNumber() {
        let number = "3"
        let isValid = evenNumberValidator.isValid(number)
        #expect(!isValid)
    }
    
    @Test("Invalid Number")
    private func invalidNumber() {
        let number = "A"
        let isValid = evenNumberValidator.isValid(number)
        #expect(!isValid)
    }
}
