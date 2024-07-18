//
//  ActivityCardType.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//

import Foundation
enum ActivityCardType {
    case transfer
    case myCard
    case insight
    
    var imageName: String {
        switch self {
        case .transfer:
            return "paperplane.fill"
        case .myCard:
            return "creditcard.fill"
        case .insight:
            return "chart.bar.fill"
        }
    }
    
    var title: String {
        switch self {
        case .transfer:
            return "Transfer"
        case .myCard:
            return "My Card"
        case .insight:
            return "Insight"
        }
    }
}
