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
            return "Account document does not exist."
        case .dataCorrupted:
            return "Account data is corrupted."
        case .firebaseError(let error):
            return "Firebase error: \(error.localizedDescription)"
        }
    }
}
