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
            return ValidationResult(errorMessage: ErrorMessages.emptyEmail.message)
        }
        
        if password.isEmpty {
            return ValidationResult(errorMessage: ErrorMessages.emptyPassword.message)
        }
        
        if !isValidEmail(email) {
            return ValidationResult(errorMessage: ErrorMessages.invalidEmail.message)
        }
        
        if password.count < 6 {
            return ValidationResult(errorMessage: ErrorMessages.shortPassword.message)
        }
        
        return ValidationResult(isValid: true)
    }
    
    static func registerValid(fullname: String, email: String, password: String, confirmPassword: String) -> ValidationResult {
        
        if fullname.isEmpty {
            return ValidationResult(errorMessage: ErrorMessages.emptyFullName.message)
        }
        
        if email.isEmpty {
            return ValidationResult(errorMessage: ErrorMessages.emptyEmail.message)
        }
        
        if password.isEmpty {
            return ValidationResult(errorMessage: ErrorMessages.emptyPassword.message)
        }
        
        if password.count < 6 {
            return ValidationResult(errorMessage: ErrorMessages.shortPassword.message)
        }
        
        if password != confirmPassword {
            return ValidationResult(errorMessage: ErrorMessages.passwordMismatch.message)
        }
        
        if !isValidEmail(email) {
            return ValidationResult(errorMessage: ErrorMessages.invalidEmail.message)
        }
        
        return ValidationResult(isValid: true)
    }
    
    static func transferValid(iban: String, amount: String, description: String) -> ValidationResult {
        if iban.isEmpty {
            return ValidationResult(errorMessage: ErrorMessages.emptyIban.message)
        }
        
        guard let amountValue = Double(amount), amountValue > 0 else {
            return ValidationResult(errorMessage: ErrorMessages.invalidAmount.message)
        }
        
        if description.isEmpty {
            return ValidationResult(errorMessage: ErrorMessages.emptyDescription.message)
        }
        if iban.count < 16{
            return ValidationResult(errorMessage: ErrorMessages.shortIban.message)
        }
        
        return ValidationResult(isValid: true)
    }
    
    
    private static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    
}


