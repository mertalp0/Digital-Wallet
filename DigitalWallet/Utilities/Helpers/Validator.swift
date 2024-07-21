//
//  Validator.swift
//  DigitalWallet
//
//  Created by Mert Alp on 11.07.2024.
//

import Foundation

struct ValidationResult {
    let isValid: Bool
    let errorMessage: String?
    
    init(isValid: Bool = false, errorMessage: String? = nil) {
        self.isValid = isValid
        self.errorMessage = errorMessage
    }
}

struct Validator {

    static func loginValid(email: String, password: String) -> ValidationResult {
        if email.isEmpty {
            return ValidationResult(errorMessage: ErrorMessages.emptyEmail)
        }
        
        if password.isEmpty {
            return ValidationResult(errorMessage: ErrorMessages.emptyPassword)
        }
        
        if !isValidEmail(email) {
            return ValidationResult(errorMessage: ErrorMessages.invalidEmail)
        }
        
        if password.count < 6 {
            return ValidationResult(errorMessage: ErrorMessages.shortPassword)
        }
        
        return ValidationResult(isValid: true)
    }
    
    static func registerValid(fullname: String, email: String, password: String, confirmPassword: String) -> ValidationResult {

        if fullname.isEmpty {
            return ValidationResult(errorMessage: ErrorMessages.emptyFullName)
        }
        
        if email.isEmpty {
            return ValidationResult(errorMessage: ErrorMessages.emptyEmail)
        }
        
        if password.isEmpty {
            return ValidationResult(errorMessage: ErrorMessages.emptyPassword)
        }
        
        if password.count < 6 {
            return ValidationResult(errorMessage: ErrorMessages.shortPassword)
        }
        
        if password != confirmPassword {
            return ValidationResult(errorMessage: ErrorMessages.passwordMismatch)
        }
        
        if !isValidEmail(email) {
            return ValidationResult(errorMessage: ErrorMessages.invalidEmail)
        }
        
        return ValidationResult(isValid: true)
    }
    
    private static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
   
}


