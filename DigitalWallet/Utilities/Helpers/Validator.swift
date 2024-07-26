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

    static func validateLogin(email: String, password: String) -> ValidationResult {
        guard !email.isEmpty else {
            return ValidationResult(errorMessage: ValidationError.emptyEmail.localizedDescription)
        }
        
        guard !password.isEmpty else {
            return ValidationResult(errorMessage: ValidationError.emptyPassword.localizedDescription)
        }
        
        guard isValidEmail(email) else {
            return ValidationResult(errorMessage: ValidationError.invalidEmail.localizedDescription)
        }
        
        guard password.count >= 6 else {
            return ValidationResult(errorMessage: ValidationError.shortPassword.localizedDescription)
        }
        
        return ValidationResult(isValid: true)
    }
    
    static func validateRegistration(fullname: String, email: String, password: String, confirmPassword: String) -> ValidationResult {
        guard !fullname.isEmpty else {
            return ValidationResult(errorMessage: ValidationError.emptyFullName.localizedDescription)
        }
        
        guard !email.isEmpty else {
            return ValidationResult(errorMessage: ValidationError.emptyEmail.localizedDescription)
        }
        
        guard !password.isEmpty else {
            return ValidationResult(errorMessage: ValidationError.emptyPassword.localizedDescription)
        }
        
        guard password.count >= 6 else {
            return ValidationResult(errorMessage: ValidationError.shortPassword.localizedDescription)
        }
        
        guard password == confirmPassword else {
            return ValidationResult(errorMessage: ValidationError.passwordMismatch.localizedDescription)
        }
        
        guard isValidEmail(email) else {
            return ValidationResult(errorMessage: ValidationError.invalidEmail.localizedDescription)
        }
        
        return ValidationResult(isValid: true)
    }
    
    static func validateTransfer(iban: String, selectedAmount: AmountCardType?, amount: String?, description: String) -> ValidationResult {
        guard !iban.isEmpty && iban != "TR" else {
            return ValidationResult(errorMessage: ValidationError.emptyIban.localizedDescription)
        }

        guard let selectedAmount = selectedAmount else {
            return ValidationResult(errorMessage: ValidationError.invalidAmount.localizedDescription)
        }
        
        if selectedAmount == .other, let amount = amount, amount.isEmpty {
            return ValidationResult(errorMessage: ValidationError.invalidAmount.localizedDescription)
        }
        
        guard !description.isEmpty else {
            return ValidationResult(errorMessage: ValidationError.emptyDescription.localizedDescription)
        }
        
        //TODO: the count will change with 32 
        guard iban.count >= 26 else {
            return ValidationResult(errorMessage: ValidationError.shortIban.localizedDescription)
        }
        
        return ValidationResult(isValid: true)
    }

    private static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
