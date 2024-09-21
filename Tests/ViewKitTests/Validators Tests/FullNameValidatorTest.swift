//
//  FullNameValidatorTests.swift
//  ViewKit
//
//  Created by Baher Tamer on 21/09/2024.
//

import Testing
@testable import ViewKit

struct FullNameValidatorTests {
    // MARK: - Setup
    private let fullNameValidator = ValidationType.fullName.validator
    
    // MARK: - Valid Cases
    @Test("Valid Full Name")
    private func validFullName() {
        let fullName = "Baher Tamer"
        let isValid = fullNameValidator.isValid(fullName)
        #expect(isValid)
    }
    
    @Test("Valid Hyphen")
    private func validFullNameWithHyphen() {
        let fullName = "Ba-her Tamer"
        let isValid = fullNameValidator.isValid(fullName)
        #expect(isValid)
    }
    
    // MARK: - Invalid Cases
    @Test("Invalid Empty")
    private func invalidEmptyFullName() {
        let fullName = ""
        let isValid = fullNameValidator.isValid(fullName)
        #expect(!isValid)
    }
    
    @Test("Invalid Spaces")
    private func invalidEmptyFullNameSpaces() {
        let fullName = " "
        let isValid = fullNameValidator.isValid(fullName)
        #expect(!isValid)
    }
    
    @Test("Invalid One Name")
    private func invalidOneName() {
        let fullName = "Baher"
        let isValid = fullNameValidator.isValid(fullName)
        #expect(!isValid)
    }
    
    @Test("Invalid Special Characters")
    private func invalidFullNameWithSpecialCharacters() {
        let fullName = "B@her T@mer"
        let isValid = fullNameValidator.isValid(fullName)
        #expect(!isValid)
    }
}
