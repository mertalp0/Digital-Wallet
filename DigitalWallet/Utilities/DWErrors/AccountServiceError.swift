//
//  AccountServiceError.swift
//  DigitalWallet
//
//  Created by mert alp on 20.07.2024.
//
import Foundation

enum AccountServiceError: LocalizedError {
    case documentNotFound
    case dataCorrupted
    case firebaseError(Error)
    
    var errorDescription: String? {
        switch self {
        case .documentNotFound:
            return LocalizedStrings.AccountError.documentNotFound
        case .dataCorrupted:
            return LocalizedStrings.AccountError.dataCorrupted
        case .firebaseError(let error):
            return String(format: LocalizedStrings.AccountError.firebaseError, error.localizedDescription)
        }
    }
}
