//
//  PhoneValidatorTests.swift
//  ViewKit
//
//  Created by Baher Tamer on 21/09/2024.
//

import Testing
@testable import ViewKit

struct PhoneValidatorTests {
    // MARK: - Setup
    private let phoneValidator = ValidationType.phone.validator
    
    // MARK: - Valid Cases
    @Test("Valid Phone Number")
    private func validPhoneNumber() {
        let phoneNumber = "01022020220"
        let isValid = phoneValidator.isValid(phoneNumber)
        #expect(isValid)
    }
    
    // MARK: - Invalid Cases
    @Test("Invalid Empty")
    private func invalidEmptyPhoneNumber() {
        let input = ""
        let isValid = phoneValidator.isValid(input)
        #expect(!isValid)
    }
    
    @Test("Invalid 01 Prefix")
    private func invalidPhoneNumberWithNo01Prefix() {
        let input = "11022020220"
        let isValid = phoneValidator.isValid(input)
        #expect(!isValid)
    }
    
    @Test("Invalid Less Than 11")
    private func invalidPhoneNumberWithShortLength() {
        let input = "0102202022"
        let isValid = phoneValidator.isValid(input)
        #expect(!isValid)
    }
    
    @Test("Invalid More Than 11")
    private func invalidPhoneNumberWithLongLength() {
        let input = "001022020220"
        let isValid = phoneValidator.isValid(input)
        #expect(!isValid)
    }
    
    @Test("Invalid Spaces")
    private func invalidPhoneNumberWithSpaces() {
        let input = "01022 20220"
        let isValid = phoneValidator.isValid(input)
        #expect(!isValid)
    }
    
    @Test("Invalid Letters")
    private func invalidPhoneNumberWithLetters() {
        let input = "01022O20220"
        let isValid = phoneValidator.isValid(input)
        #expect(!isValid)
    }
    
    @Test("Invalid Special Characters")
    private func invalidPhoneNumberWithSpecialCharacters() {
        let input = "01022*20220"
        let isValid = phoneValidator.isValid(input)
        #expect(!isValid)
    }
}
