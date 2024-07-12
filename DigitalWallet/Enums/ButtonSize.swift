//
//  ButtonSize.swift
//  DigitalWallet
//
//  Created by mert alp on 12.07.2024.
//

import Foundation

enum ButtonSize {
    case small
    case medium
    case large
    
    var size: CGSize {
        switch self {
        case .small:
            return CGSize(width: 80, height: 15)
        case .medium:
            return CGSize(width: 150, height: 15)
        case .large:
            return CGSize(width: 300, height: 15)
        }
    }
}

