//
//  NationalIdValidatorTests.swift
//  ViewKit
//
//  Created by Baher Tamer on 21/09/2024.
//

import Testing
@testable import ViewKit

struct NationalIdValidatorTests {
    // MARK: - Setup
    private let nationalIdValidator = ValidationType.nationalId.validator
    
    // MARK: - Valid Cases
    @Test("Valid National Number")
    private func validNationalNumber() {
        let nationalNumber = "30003300303333"
        let isValid = nationalIdValidator.isValid(nationalNumber)
        #expect(isValid)
    }
    
    // MARK: - Invalid Cases
    @Test("Invalid Empty")
    private func invalidEmptyNationalNumber() {
        let nationalNumber = ""
        let isValid = nationalIdValidator.isValid(nationalNumber)
        #expect(!isValid)
    }
    
    @Test("Invalid Spaces")
    private func invalidEmptyNationalNumberSpaces() {
        let nationalNumber = " "
        let isValid = nationalIdValidator.isValid(nationalNumber)
        #expect(!isValid)
    }
    
    @Test("Invalid Letters")
    private func invalidNationalNumberWithLetters() {
        let nationalNumber = "300033AA303333"
        let isValid = nationalIdValidator.isValid(nationalNumber)
        #expect(!isValid)
    }
    
    @Test("Invalid Less Than 14")
    private func invalidNationalNumberWithShortLength() {
        let nationalNumber = "3000330030"
        let isValid = nationalIdValidator.isValid(nationalNumber)
        #expect(!isValid)
    }
    
    @Test("Invalid More Than 14")
    private func invalidNationalNumberWithLongLength() {
        let nationalNumber = "300033AA3033330000"
        let isValid = nationalIdValidator.isValid(nationalNumber)
        #expect(!isValid)
    }
    
    @Test("Invalid Format")
    private func invalidNationalNumberFormat() {
        let nationalNumber = "50003300303333" // Doesn't start with 2 or 3
        let isValid = nationalIdValidator.isValid(nationalNumber)
        #expect(!isValid)
    }
}
