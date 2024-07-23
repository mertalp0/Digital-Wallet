//
//  AuthenticationServiceError.swift
//  DigitalWallet
//
//  Created by mert alp on 20.07.2024.
//

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
        let description = AuthenticationServiceError.errorDescription(for: type)
        super.init(type: .custom(description))
    }
    
    private static func errorDescription(for type: ErrorType) -> String {
        switch type {
        case .firebaseError(let error):
            return String(format: LocalizedStrings.AuthenticationError.firebaseError, error.localizedDescription)
        case .firebaseDocumentNotFound:
            return LocalizedStrings.AuthenticationError.firebaseDocumentNotFound
        case .firebaseDataCorrupted:
            return LocalizedStrings.AuthenticationError.firebaseDataCorrupted
        case .userNotAuthenticated:
            return LocalizedStrings.AuthenticationError.userNotAuthenticated
        case .userNotFound:
            return LocalizedStrings.AuthenticationError.userNotFound
        case .emailNotVerified:
            return LocalizedStrings.AuthenticationError.emailNotVerified
        case .userNotCreated:
            return LocalizedStrings.AuthenticationError.userNotCreated
        case .accountCreationFailed:
            return LocalizedStrings.AuthenticationError.accountCreationFailed
        case .encryptionFailed:
            return LocalizedStrings.AuthenticationError.encryptionFailed
        }
    }
}
