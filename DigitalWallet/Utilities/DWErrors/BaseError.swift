//
//  BaseError.swift
//  DigitalWallet
//
//  Created by mert alp on 20.07.2024.
//

import Foundation

class BaseError: LocalizedError {
    enum ErrorType {
        case custom(String)
    }
    
    private let type: ErrorType
    
    init(type: ErrorType) {
        self.type = type
    }
    
    var errorDescription: String? {
        switch type {
        case .custom(let message):
            return message
        }
    }
}
