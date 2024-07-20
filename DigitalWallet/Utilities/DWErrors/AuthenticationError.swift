//
//  AuthenticationServiceError.swift
//  DigitalWallet
//
//  Created by mert alp on 20.07.2024.
//

import Foundation

class AuthenticationServiceError: BaseError {
    enum ErrorType {
        // Firebase Error Types
        case firebaseError(Error)
        case firebaseDocumentNotFound
        case firebaseDataCorrupted
        
        // Authentication Error Types
        case userNotAuthenticated
        case userNotFound
        case emailNotVerified
        case userNotCreated
        case accountCreationFailed
        case encryptionFailed
    }
    
    init(type: ErrorType) {
        super.init(type: .custom(AuthenticationServiceError.errorDescription(for: type)))
    }
    
    private static func errorDescription(for type: ErrorType) -> String {
        switch type {
        case .firebaseError(let error):
            return "Firebase error: \(error.localizedDescription)"
        case .firebaseDocumentNotFound:
            return "Firebase document not found."
        case .firebaseDataCorrupted:
            return "Firebase data is corrupted."
        case .userNotAuthenticated:
            return "User is not authenticated."
        case .userNotFound:
            return "User not found."
        case .emailNotVerified:
            return "Email address not verified."
        case .userNotCreated:
            return "User was not created successfully."
        case .accountCreationFailed:
            return "Account creation failed."
        case .encryptionFailed:
            return "Password encryption failed."
        }
    }
}
