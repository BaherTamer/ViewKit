//
//  ValidationType+Validators.swift
//  ViewKit
//
//  Created by Baher Tamer on 20/09/2024.
//

extension ValidationType {
    /// Returns an appropriate ``Validator`` instance based on the selected ``ValidationType``.\
    /// This property will provide the necessary validation logic for the corresponding case.
    var validator: Validator {
        switch self {
        case .email:
            EmailValidator()
        case .fullName:
            FullNameValidator()
        case .nationalId:
            NationalIdValidator()
        case .password:
            PasswordValidator()
        case .phone:
            PhoneValidator()
        case .required:
            RequiredValidator()
        case .custom(let customValidator):
            customValidator
        }
    }
}
