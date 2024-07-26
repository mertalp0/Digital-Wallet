//
//  ErrorMessages.swift
//  DigitalWallet
//
//  Created by mert alp on 12.07.2024.
//

import Foundation

enum ValidationError: LocalizedError {
    case emptyEmail
    case emptyPassword
    case invalidEmail
    case shortPassword
    case emptyFullName
    case passwordMismatch
    case emptyIban
    case invalidAmount
    case emptyDescription
    case shortIban
    //TODO: Must be in localizable
    var errorDescription: String? {
        switch self {
        case .emptyEmail:
            return "Email cannot be empty."
        case .emptyPassword:
            return "Password cannot be empty."
        case .invalidEmail:
            return "Email format is invalid."
        case .shortPassword:
            return "Password must be at least 6 characters long."
        case .emptyFullName:
            return "Full name cannot be empty."
        case .passwordMismatch:
            return "Passwords do not match."
        case .emptyIban:
            return "IBAN cannot be empty."
        case .invalidAmount:
            return "Amount is invalid."
        case .emptyDescription:
            return "Description cannot be empty."
        case .shortIban:
            return "IBAN is too short."
        }
    }
}
