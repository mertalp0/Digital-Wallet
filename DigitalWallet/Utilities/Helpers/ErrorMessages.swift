//
//  ErrorMessages.swift
//  DigitalWallet
//
//  Created by mert alp on 12.07.2024.
//

import Foundation

enum ErrorMessages: String {
    case emptyFullName = "Please enter your fullname."
    case emptyEmail = "Please enter your email address."
    case emptyPassword = "Please enter a password."
    case invalidEmail = "Please enter a valid email address."
    case shortPassword = "Password must be at least 6 characters long."
    case passwordMismatch = "Passwords do not match."
    case emptyIban = "Please enter an IBAN."
    case invalidAmount = "Please enter a valid amount."
    case emptyDescription = "Please enter a description."
    case shortIban = "Password must be at least 16 characters long."
    
    var message: String {
        return self.rawValue
    }
}
