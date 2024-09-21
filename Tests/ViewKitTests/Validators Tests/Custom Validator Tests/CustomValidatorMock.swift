//
//  CustomValidatorMock.swift
//  ViewKit
//
//  Created by Baher Tamer on 21/09/2024.
//

import ViewKit

struct EvenNumberValidator: Validator {
    func validate(_ value: String) -> ValidationError? {
        guard let number = Int(value) else {
            return ValidationError("Invalid Number")
        }
        
        guard number % 2 == 0 else {
            return ValidationError("Number Must Be Even")
            
        }
        
        return nil
    }
}
