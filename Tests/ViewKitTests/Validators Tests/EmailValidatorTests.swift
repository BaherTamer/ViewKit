//
//  File.swift
//  ViewKit
//
//  Created by Baher Tamer on 21/09/2024.
//

import Testing
@testable import ViewKit

struct EmailValidatorTests {
    // MARK: - Setup
    private let emailValidator = ValidationType.email.validator
    
    // MARK: - Valid Cases
    @Test("Valid Email")
    private func validEmail() {
        let email = "baher.tamer@email.com"
        let isValid = emailValidator.isValid(email)
        #expect(isValid)
    }
    
    @Test("Valid Uppercased")
    private func validUppercasedEmail() {
        let email = "BAHER.TAMER@EMAIL.COM"
        let isValid = emailValidator.isValid(email)
        #expect(isValid)
    }
    
    // MARK: - Invalid Cases
    @Test("Invalid Empty")
    private func invalidEmptyEmail() {
        let email = ""
        let isValid = emailValidator.isValid(email)
        #expect(!isValid)
    }
    
    @Test("Invalid Spaces Only")
    private func invalidEmptyEmailSpaces() {
        let email = " "
        let isValid = emailValidator.isValid(email)
        #expect(!isValid)
    }
    
    @Test("Invalid Spaces")
    private func invalidEmailWithSpaces() {
        let email = "baher tamer@email.com"
        let isValid = emailValidator.isValid(email)
        #expect(!isValid)
    }
    
    @Test("Invalid Format")
    private func invalidEmailFormat() {
        let email = "email.com"
        let isValid = emailValidator.isValid(email)
        #expect(!isValid)
    }
    
    @Test("Invalid Special Characters")
    private func invalidEmailWithSpecialCharacters() {
        let email = "!#$%&'*+-/=?^_`{|}~@email.com"
        let isValid = emailValidator.isValid(email)
        #expect(!isValid)
    }
    
    @Test("Invalid Missing Domain")
    private func invalidEmailWithMissingDomain() {
        let email = "baher.tamer@.com"
        let isValid = emailValidator.isValid(email)
        #expect(!isValid)
    }
    
    @Test("Invalid Missing Extension")
    private func invalidEmailWithMissingExtension() {
        let email = "baher.tamer@email"
        let isValid = emailValidator.isValid(email)
        #expect(!isValid)
    }
}
