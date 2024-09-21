//
//  PasswordValidatorTests.swift
//  ViewKit
//
//  Created by Baher Tamer on 21/09/2024.
//

import Testing
@testable import ViewKit

struct PasswordValidatorTests {
    // MARK: - Setup
    private let passwordValidator = ValidationType.password.validator
    
    // MARK: - Valid Cases
    @Test("Valid Password")
    private func validPassword() {
        let password = "Aa@123456"
        let isValid = passwordValidator.isValid(password)
        #expect(isValid)
    }
    
    // MARK: - Invalid Cases
    @Test("Invalid Empty")
    private func invalidEmptyPassword() {
        let password = ""
        let isValid = passwordValidator.isValid(password)
        #expect(!isValid)
    }
    
    @Test("Invalid Short")
    private func invalidShortPassword() {
        let password = "Aa@123"
        let isValid = passwordValidator.isValid(password)
        #expect(!isValid)
    }
    
    @Test("Invalid No Uppercase")
    private func invalidPasswordWithNoUppercase() {
        let password = "aa@123456"
        let isValid = passwordValidator.isValid(password)
        #expect(!isValid)
    }
    
    @Test("Invalid No Lowercase")
    private func invalidPasswordWithNoLowercase() {
        let password = "AA@123456"
        let isValid = passwordValidator.isValid(password)
        #expect(!isValid)
    }
    
    @Test("Invalid No Number")
    private func invalidPasswordWithNoNumber() {
        let password = "AA@abcdef"
        let isValid = passwordValidator.isValid(password)
        #expect(!isValid)
    }
    
    @Test("Invalid No Special Character")
    private func invalidPasswordWithNoSpecialCharacter() {
        let password = "AA0123456"
        let isValid = passwordValidator.isValid(password)
        #expect(!isValid)
    }
    
    @Test("Invalid Spaces")
    private func invalidPasswordWithSpaces() {
        let password = "Aa@ 123456"
        let isValid = passwordValidator.isValid(password)
        #expect(!isValid)
    }
}
