//
//  UserServiceError.swift
//  DigitalWallet
//
//  Created by mert alp on 20.07.2024.
//

import Foundation

class UserServiceError: BaseError {
    enum ErrorType {
        case userNotAuthenticated
        case userDocumentNotFound
        case userDataCorrupted
        case firebaseError(Error) // Firebase hatalarını buraya ekledik
    }
    
    private let type: ErrorType
    
    init(type: ErrorType) {
        self.type = type
        super.init(type: .custom(UserServiceError.errorDescription(for: type)))
    }
    
    private static func errorDescription(for type: ErrorType) -> String {
        switch type {
        case .userNotAuthenticated:
            return "User is not authenticated."
        case .userDocumentNotFound:
            return "User document does not exist."
        case .userDataCorrupted:
            return "User data is corrupted."
        case .firebaseError(let error):
            return "Firebase error: \(error.localizedDescription)"
        }
    }
}
