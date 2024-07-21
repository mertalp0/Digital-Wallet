//
//  UserServiceError.swift
//  DigitalWallet
//
//  Created by mert alp on 20.07.2024.
//

class UserServiceError: BaseError {
    enum ErrorType {
        case userNotAuthenticated
        case userDocumentNotFound
        case userDataCorrupted
        case firebaseError(Error)
    }
    
    private let type: ErrorType
    
    init(type: ErrorType) {
        self.type = type
        super.init(type: .custom(UserServiceError.errorDescription(for: type)))
    }
    
    private static func errorDescription(for type: ErrorType) -> String {
        switch type {
        case .userNotAuthenticated:
            return LocalizedStrings.UserError.userNotAuthenticated
        case .userDocumentNotFound:
            return LocalizedStrings.UserError.userDocumentNotFound
        case .userDataCorrupted:
            return LocalizedStrings.UserError.userDataCorrupted
        case .firebaseError(let error):
            return String(format: LocalizedStrings.UserError.firebaseError, error.localizedDescription)
        }
    }
}
